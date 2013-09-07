(function() {
  (function() {})();

}).call(this);

(function() {


}).call(this);

(function() {
  udefine('pencilbox/interface/methods', function() {
    var methods;
    return methods = ['drawTexture', 'drawRect', 'drawCircle', 'drawLine', 'drawPoint'];
  });

}).call(this);

(function() {
  udefine('pencilbox/provider/canvas', function() {
    var CanvasProvider;
    return CanvasProvider = (function() {
      function CanvasProvider(elementId, options) {
        var elem, height, parent, width;
        if (elementId == null) {
          elementId = "canvas-" + (Date.now());
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

}).call(this);
