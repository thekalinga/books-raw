// ==UserScript==
// @name         bareactslive
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        http://www.bareactslive.com/*
// @icon         https://www.google.com/s2/favicons?domain=bareactslive.com
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    function classStartsWith(el, classNamePrefix) {
        if (el.classList) {
            var matched = false;
            for(var i = 0; i < el.classList.length; ++i) {
                matched = el.classList[i].indexOf(classNamePrefix) !== -1;
                if (matched) {
                    break;
                }
            }
            return matched;
        } else {
            return !!el.className.match(new RegExp('(\\s|^)' + classNamePrefix));
        }
    }

    function findParentElementWithClassNamePrefix(anchorNode, classNamePrefix) {
        var currentNode = anchorNode;
        do {
            if (classStartsWith(currentNode, classNamePrefix)) {
                break;
            }
            currentNode = currentNode.parentNode;
        } while(currentNode != null);
        return currentNode;
    }

    function findFirstElementWithBodyText(bodyText) {
        return document.evaluate("//*[contains(text(), '" + bodyText + "')]", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0);
    }

    function findFirstElementWithNameAndBodyText(elementName, bodyText) {
        return findAllElementsWithNameAndBodyText(elementName, bodyText).snapshotItem(0);
    }

    function findAllElementsWithXpath(xpath) {
        return document.evaluate(xpath, document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
    }

    function findAllElementsWithXpathAndApply(xpath, fn) {
        const matches = findAllElementsWithXpath(xpath);
        for (let i = 0, length = matches.snapshotLength; i < length; ++i) {
            const match = matches.snapshotItem(i);
            fn(match);
        }
    }

    function findAllElementsWithNameAndBodyText(elementName, bodyText) {
        // normalize-space = trim
        // lower-case() is only available in xpath 2.0, so, we use the following hack
        // translate(text, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = converting from upper case to lowercase
        return findAllElementsWithXpath(`//${elementName}[contains(translate(normalize-space(text()), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '${bodyText}')]`);
    }

    function findAllElementsWithNameAndBodyTextAndApply(elementName, bodyText, fn) {
        const matches = findAllElementsWithNameAndBodyText(elementName, bodyText);
        for (let i = 0, length = matches.snapshotLength; i < length; ++i) {
            const match = matches.snapshotItem(i);
            fn(match);
        }
    }

    function hasClass(el, className) {
        if (el.classList) {
            return el.classList.contains(className);
        } else {
            return !!el.className.match(new RegExp('(\\s|^)' + className + '(\\s|$)'));
        }
    }

    function addClass(el, className) {
        if (el.classList) {
            el.classList.add(className);
        }
        else if (!hasClass(el, className)) {
            el.className += " " + className;
        }
    }

    function removeClass(el, className) {
        if (el.classList) {
            el.classList.remove(className);
        } else if (hasClass(el, className)) {
            var reg = new RegExp('(\\s|^)' + className + '(\\s|$)');
            el.className=el.className.replace(reg, ' ');
        }
    }

    function waitForElementAndExecute(elementEvaluator, fnToExecute) {
        const element = elementEvaluator();
        if (!element) {
            console.log('waiting for 100ms as the element couldnt be found')
            setTimeout(() => waitForElementAndExecute(elementEvaluator, fnToExecute), 100);
            return;
        }
        fnToExecute();
    }

    function undo() {
        removeClass(document.getElementsByTagName('body')[0], 'toggle');
        toggle.src = showNavIcon;
    }

    function apply() {
        addClass(document.getElementsByTagName('body')[0], 'toggle');
        toggle.src = hideNavIcon;
    }

    var showing = false;
    var hideNavIcon = 'data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+DQo8c3ZnDQogICB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciDQogICB3aWR0aD0iMTAwJSINCiAgIGhlaWdodD0iMTAwJSINCiAgIHZpZXdCb3g9IjAgMCAyMDQ4IDE3OTIiPg0KICA8cGF0aA0KICAgICBkPSJNMCA4OTZxMC0xMzAgNTEtMjQ4LjV0MTM2LjUtMjA0IDIwNC0xMzYuNSAyNDguNS01MWg3NjhxMTMwIDAgMjQ4LjUgNTF0MjA0IDEzNi41IDEzNi41IDIwNCA1MSAyNDguNS01MSAyNDguNS0xMzYuNSAyMDQtMjA0IDEzNi41LTI0OC41IDUxaC03NjhxLTEzMCAwLTI0OC41LTUxdC0yMDQtMTM2LjUtMTM2LjUtMjA0LTUxLTI0OC41ek0xNDA4IDE0MDhxMTA0IDAgMTk4LjUtNDAuNXQxNjMuNS0xMDkuNSAxMDkuNS0xNjMuNSA0MC41LTE5OC41LTQwLjUtMTk4LjUtMTA5LjUtMTYzLjUtMTYzLjUtMTA5LjUtMTk4LjUtNDAuNS0xOTguNSA0MC41LTE2My41IDEwOS41LTEwOS41IDE2My41LTQwLjUgMTk4LjUgNDAuNSAxOTguNSAxMDkuNSAxNjMuNSAxNjMuNSAxMDkuNSAxOTguNSA0MC41eiINCiAgICAgaWQ9InBhdGgyIg0KICAgICBzdHlsZT0iZmlsbDojZmZhYTc1O2ZpbGwtb3BhY2l0eToxIiAvPg0KPC9zdmc+';
    var showNavIcon = 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIHZpZXdCb3g9IjAgMCAyMDQ4IDE3OTIiPjxwYXRoIGZpbGw9InJnYigxODksMTg5LDE4OSkiIGQ9Ik0xMTUyIDg5NnEwLTEwNC00MC41LTE5OC41dC0xMDkuNS0xNjMuNS0xNjMuNS0xMDkuNS0xOTguNS00MC41LTE5OC41IDQwLjUtMTYzLjUgMTA5LjUtMTA5LjUgMTYzLjUtNDAuNSAxOTguNSA0MC41IDE5OC41IDEwOS41IDE2My41IDE2My41IDEwOS41IDE5OC41IDQwLjUgMTk4LjUtNDAuNSAxNjMuNS0xMDkuNSAxMDkuNS0xNjMuNSA0MC41LTE5OC41ek0xOTIwIDg5NnEwLTEwNC00MC41LTE5OC41dC0xMDkuNS0xNjMuNS0xNjMuNS0xMDkuNS0xOTguNS00MC41aC0zODZxMTE5IDkwIDE4OC41IDIyNHQ2OS41IDI4OC02OS41IDI4OC0xODguNSAyMjRoMzg2cTEwNCAwIDE5OC41LTQwLjV0MTYzLjUtMTA5LjUgMTA5LjUtMTYzLjUgNDAuNS0xOTguNXpNMjA0OCA4OTZxMCAxMzAtNTEgMjQ4LjV0LTEzNi41IDIwNC0yMDQgMTM2LjUtMjQ4LjUgNTFoLTc2OHEtMTMwIDAtMjQ4LjUtNTF0LTIwNC0xMzYuNS0xMzYuNS0yMDQtNTEtMjQ4LjUgNTEtMjQ4LjUgMTM2LjUtMjA0IDIwNC0xMzYuNSAyNDguNS01MWg3NjhxMTMwIDAgMjQ4LjUgNTF0MjA0IDEzNi41IDEzNi41IDIwNCA1MSAyNDguNXoiLz48L3N2Zz4=';

    var toggle = document.createElement('img');
    toggle.src = hideNavIcon;
    toggle.style.position = 'fixed';
    toggle.style.bottom = "10px";
    toggle.style.right = "10px";
    toggle.style.width = "20px";
    toggle.style.height = "20px";
    toggle.style.cursor = "pointer";
    toggle.style.zIndex = "2147483647";
    toggle.style.display = "block";

    toggle.addEventListener("click", function() {
        if (!showing) {
            apply();
        } else {
            undo();
        }
        showing = !showing;
    });

    document.getElementsByTagName('body')[0].appendChild(toggle);

    var newStyleToBeApplied = document.createElement('style');
    newStyleToBeApplied.type= 'text/css';
    newStyleToBeApplied.innerHTML = `
.toggle .custom-hidden-marker,
.toggle header,
.toggle .navbar,
.toggle #recaptcha,
.toggle .modal-backdrop,
.toggle .modal,
.toggle .copy
{
    display: none!important;
}
.toggle p,
.toggle a,
.toggle blockquote,
.toggle font
{
    font-family: "PT Serif"!important;
    line-height: 28px!important;
    font-size: 17px!important;
    letter-spacing: .5px!important;
    color: rgba(0,0,0,.95)!important;
    text-align: initial;
}

.toggle h1,
.toggle h2,
.toggle h3,
.toggle h4,
.toggle h5,
.toggle h6,
.toggle .h1,
.toggle .h2,
.toggle .h3,
.toggle .h4,
.toggle .h5,
.toggle .h6
{
  font-family: Hind!important;
}

.toggle #left
{
  top: 20px;
  left: 20px;
}

.toggle #right
{
  top: 20px;
  padding: 40px;
}
`;
    document.getElementsByTagName('head')[0].appendChild(newStyleToBeApplied);

    apply();
    showing = !showing;

})();