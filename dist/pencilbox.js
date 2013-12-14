(function() {
  (function() {})();

}).call(this);

(function() {
  udefine('pencilbox', function() {});

  udefine('pencilbox/methods', function() {
    var methods;
    return methods = ['drawCircle', 'drawEllipse', 'drawImage', 'drawImageRect', 'drawLine', 'drawOval', 'drawPoint', 'drawRect', 'drawText'];
  });

  udefine('pencilbox/provider/canvas', function() {
    var CanvasProvider;
    return CanvasProvider = (function() {
      function CanvasProvider(elementId, options) {
        var elem, height, parent, width;
        if (elementId == null) {
          elementId = "pencilbox-" + (Date.now());
        }
        if (options != null) {
          parent = options.parent, width = options.width, height = options.height;
        }
        if (!document.getElementById(elementId)) {
          elem = document.createElement('canvas');
          elem.id = elementId;
          if (width) {
            elem.width = width;
          }
          if (height) {
            elem.height = height;
          }
          if (parent === 'body' || !parent) {
            document.body.appendChild(elem);
          } else {
            document.getElementById(parent).appendChild(elem);
          }
        }
        elem = document.getElementById(elementId);
        this.context = elem.getContext('2d');
      }

      CanvasProvider.prototype.drawRect = function(x, y, w, h) {};

      return CanvasProvider;

    })();
  });

  udefine('pencilbox/provider/dom', function() {
    var DOMProvider, createElement, elements, pixelize;
    elements = 0;
    pixelize = function(num) {
      if (typeof num === 'number') {
        return num + 'px';
      } else {
        return num;
      }
    };
    createElement = function(parent, attributes, styles) {
      var elem, key, styleKey, styleValue, value;
      elem = document.createElement('div');
      for (key in attributes) {
        value = attributes[key];
        elem[key] = value;
      }
      for (styleKey in styles) {
        styleValue = styles[styleKey];
        elem.style[styleKey] = styleValue;
      }
      if (parent === 'body' || !parent) {
        document.body.appendChild(elem);
      } else {
        document.getElementById(parent).appendChild(elem);
      }
      elements++;
      return elem;
    };
    return DOMProvider = (function() {
      function DOMProvider(elementId, options) {
        var elem, height, parent, width;
        if (elementId == null) {
          elementId = "pencilbox-" + (Date.now());
        }
        if (typeof elementId === 'object') {
          options = elementId;
          elementId = "pencilbox-" + (Date.now());
        }
        if (options != null) {
          parent = options.parent, width = options.width, height = options.height;
        }
        width = pixelize(width);
        height = pixelize(height);
        if (!document.getElementById(elementId)) {
          createElement(parent, {
            id: elementId,
            className: 'pencilbox'
          }, {
            width: width,
            height: height
          });
        }
        elem = document.getElementById(elementId);
        this.root = elementId;
      }

      DOMProvider.prototype.drawRect = function(x, y, w, h) {
        var styles;
        styles = {
          position: 'absolute',
          left: pixelize(x),
          top: pixelize(y),
          width: pixelize(w),
          height: pixelize(h)
        };
        return createElement(this.root, {
          id: "pb-element-" + element,
          className: 'element rect'
        }, styles);
      };

      return DOMProvider;

    })();
  });

  udefine('pencilbox/provider', function() {
    var Provider;
    Provider = {};
    Provider.defaultProvider = 'CanvasProvider';
    return Provider;
  });

}).call(this);
