(function() {
  (function() {})();

}).call(this);

(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  udefine('pencilbox/constants', function() {
    return {
      defaultWidth: 800,
      defaultHeight: 480
    };
  });

  udefine('pencilbox/core/property', function() {
    var property;
    return property = function(context, name, reference) {
      return Object.defineProperty(context, name, {
        get: function() {
          return reference;
        },
        set: function(value) {
          if (value !== reference) {
            if (typeof context.trigger === "function") {
              context.trigger('property:change', name, value);
            }
            return reference = value;
          }
        }
      });
    };
  });

  udefine('pencilbox/element/all', ['pencilbox/element', './circle', './rect'], function(Element, Circle, Rect) {
    return {
      Element: Element,
      Circle: Circle,
      Rect: Rect
    };
  });

  udefine('pencilbox/element/circle', ['pencilbox/element', 'pencilbox/core/property'], function(Element, property) {
    var CircleElement;
    return CircleElement = (function(_super) {
      __extends(CircleElement, _super);

      function CircleElement(left, top, width, height) {
        if (left == null) {
          left = 0;
        }
        if (top == null) {
          top = 0;
        }
        if (width == null) {
          width = 100;
        }
        if (height == null) {
          height = 100;
        }
        this.type = 'circle';
        property(this, 'width', width);
        property(this, 'height', height);
        CircleElement.__super__.constructor.call(this, left, top);
      }

      return CircleElement;

    })(Element);
  });

  udefine('pencilbox/element', ['mixedice', 'eventmap', 'pencilbox/core/property'], function(mixedice, EventMap, property) {
    var Element;
    return Element = (function() {
      function Element(left, top) {
        if (left == null) {
          left = 0;
        }
        if (top == null) {
          top = 0;
        }
        mixedice([this, Element.prototype], new EventMap());
        property(this, 'left', left);
        property(this, 'top', top);
        this.type = 'none';
        this.on('created', this.onCreate);
        this.trigger('created', this.type, this);
      }

      Element.onCreate = function() {};

      return Element;

    })();
  });

  udefine('pencilbox/element/rect', ['pencilbox/element', 'pencilbox/core/property'], function(Element, property) {
    var RectElement;
    return RectElement = (function(_super) {
      __extends(RectElement, _super);

      function RectElement(left, top, width, height) {
        if (left == null) {
          left = 0;
        }
        if (top == null) {
          top = 0;
        }
        if (width == null) {
          width = 100;
        }
        if (height == null) {
          height = 100;
        }
        this.type = 'rect';
        property(this, 'width', width);
        property(this, 'height', height);
        RectElement.__super__.constructor.call(this, left, top);
      }

      return RectElement;

    })(Element);
  });

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

  udefine('pencilbox/provider/dom', ['pencilbox/constants', 'pencilbox/element/all'], function(Constants, Elements) {
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
        var elem, height, parent, width,
          _this = this;
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
        width = width || Constants.defaultWidth;
        height = height || Constants.defaultHeight;
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
        Elements.Element.onCreate = function(type, instance) {
          var element, size, styles;
          element = "" + type + "-" + (Date.now());
          styles = {
            position: 'absolute'
          };
          styles['left'] = pixelize(instance.left);
          styles['top'] = pixelize(instance.top);
          switch (type) {
            case 'circle':
              size = instance.width > instance.height ? instance.width : instance.height;
              styles['width'] = styles['height'] = pixelize(size);
              styles['border-radius'] = pixelize(size / 2);
              break;
            case 'rect':
              styles['width'] = pixelize(instance.width);
              styles['height'] = pixelize(instance.height);
          }
          return createElement(_this.root, {
            id: "pb-element-" + element,
            className: "element " + type
          }, styles);
        };
      }

      DOMProvider.prototype.drawCircle = function(x, y, size) {
        return new Elements.Circle(x, y, size, size);
      };

      DOMProvider.prototype.drawRect = function(x, y, w, h) {
        return new Elements.Rect(x, y, w, h);
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
