package com.sulake.core.window
{
    import com.sulake.core.window.graphics.IGraphicContextHost;
    import com.sulake.core.window.utils.IChildWindowHost;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowEventDispatcher;
    import com.sulake.core.window.graphics.IGraphicContext;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.utils.WindowRectLimits;
    import com.sulake.core.window.dynamicstyle.DynamicStyle;
    import com.sulake.core.window.theme.IPropertyMap;
    import com.sulake.core.window.utils.DefaultAttStruct;
    import com.sulake.core.window.utils.IRectLimiter;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.events.WindowDisposeEvent;
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.utils.Map;
    import flash.display.IBitmapDrawable;
    import com.sulake.core.window.services.IMouseListenerService;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.dynamicstyle.DynamicStyleManager;
    import flash.display.BitmapData;
    import com.sulake.core.window.utils.PropertyStruct;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class WindowController extends WindowModel implements IWindow, IGraphicContextHost, IChildWindowHost 
    {

        private static const _SafeStr_1228:Rectangle = new Rectangle();
        public static const TAG_EXCLUDE:String = "_EXCLUDE";
        public static const TAG_INTERNAL:String = "_INTERNAL";
        public static const TAG_COLORIZE:String = "_COLORIZE";
        public static const TAG_IGNORE_INHERITED_STYLE:String = "_IGNORE_INHERITED_STYLE";
        private static const _POINT_ZERO:Point = new Point();

        private static var _SafeStr_1224:uint = 0;

        protected var _SafeStr_913:WindowEventDispatcher;
        protected var _SafeStr_897:IGraphicContext;
        protected var _SafeStr_900:Function;
        protected var _SafeStr_899:Boolean = true;
        protected var _parent:WindowController;
        protected var _children:Vector.<IWindow>;
        protected var _SafeStr_845:Boolean = false;
        protected var _SafeStr_1229:WindowRectLimits;
        protected var _SafeStr_912:Boolean = false;
        private var _SafeStr_1234:DynamicStyle;
        private var _SafeStr_1235:Boolean = false;
        private var _SafeStr_1233:Rectangle;
        private var _SafeStr_1236:uint = _SafeStr_1224++;
        private var _SafeStr_1237:IPropertyMap;

        public function WindowController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0, _arg_12:String="")
        {
            var _local_13:uint;
            var _local_14:XML = _arg_5.getWindowFactory().getLayoutByTypeAndStyle(_arg_2, _arg_3);
            if (_arg_6 == null)
            {
                _arg_6 = new Rectangle(0, 0, ((_local_14) ? _local_14.attribute("width") : 10), ((_local_14) ? _local_14.attribute("height") : 10));
            };
            _SafeStr_1237 = _arg_5.getWindowFactory().getThemeManager().getPropertyDefaults(_arg_3);
            super(_arg_11, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_10, _arg_12);
            if (!_SafeStr_897)
            {
                _SafeStr_897 = getGraphicContext((!(testParamFlag(16))));
            };
            _SafeStr_1233 = new Rectangle();
            if (_local_14 != null)
            {
                _SafeStr_1225 = new Rectangle(0, 0, _local_14.attribute("width"), _local_14.attribute("height"));
                _SafeStr_1227 = _SafeStr_1225.clone();
                _SafeStr_954 = _SafeStr_1225.x;
                _SafeStr_955 = _SafeStr_1225.y;
                _SafeStr_908 = _SafeStr_1225.width;
                _SafeStr_909 = _SafeStr_1225.height;
                _arg_5.getWindowParser().parseAndConstruct(_local_14, this, null);
                _local_13 = _SafeStr_1226;
                _SafeStr_1226 = (_SafeStr_1226 & (~(0xC00000)));
                setRectangle(_arg_6.x, _arg_6.y, _arg_6.width, _arg_6.height);
                _SafeStr_1226 = _local_13;
                _SafeStr_1227.x = _arg_6.x;
                _SafeStr_1227.y = _arg_6.y;
                _SafeStr_1227.width = _arg_6.width;
                _SafeStr_1227.height = _arg_6.height;
            };
            var _local_15:DefaultAttStruct = _arg_5.getWindowFactory().getDefaultsByTypeAndStyle(_arg_2, _arg_3);
            if (_local_15)
            {
                _SafeStr_1230 = _local_15.blend;
                _SafeStr_1239 = _local_15.threshold;
                if (_background != _local_15.background)
                {
                    background = _local_15.background;
                };
                if (_fillColor != _local_15.color)
                {
                    color = _local_15.color;
                };
                if (_local_15.hasRectLimits())
                {
                    WindowRectLimits(limits).assign(_local_15.width_min, _local_15.width_max, _local_15.height_min, _local_15.height_max);
                };
            };
            if (_arg_9)
            {
                this.properties = _arg_9;
            };
            _SafeStr_900 = _arg_8;
            if (_arg_7 != null)
            {
                _parent = (_arg_7 as WindowController);
                WindowController(_arg_7).addChild(this);
                if (_SafeStr_897)
                {
                    _context.invalidate(this, null, 1);
                };
            };
        }

        private static function calculateMouseRegion(_arg_1:WindowController, _arg_2:Rectangle):void
        {
            var _local_7:int;
            var _local_3:Rectangle = new Rectangle();
            _arg_1.getGlobalRectangle(_local_3);
            var _local_5:int = _arg_1.numChildren;
            var _local_4:int = _local_3.x;
            var _local_6:int = _local_3.y;
            _arg_2.left = ((_local_4 < _arg_2.left) ? _local_4 : _arg_2.left);
            _arg_2.top = ((_local_6 < _arg_2.top) ? _local_6 : _arg_2.top);
            _arg_2.right = ((_local_3.right > _arg_2.right) ? _local_3.right : _arg_2.right);
            _arg_2.bottom = ((_local_3.bottom > _arg_2.bottom) ? _local_3.bottom : _arg_2.bottom);
            _local_7 = 0;
            while (_local_7 < _local_5)
            {
                WindowController.calculateMouseRegion((_arg_1.getChildAt(_local_7) as WindowController), _arg_2);
                _local_7++;
            };
        }

        public static function expandToAccommodateChild(_arg_1:WindowController, _arg_2:IWindow):void
        {
            var _local_6:uint;
            var _local_9:uint;
            var _local_4:int;
            var _local_3:int;
            var _local_10:int = _arg_1.width;
            var _local_5:int = _arg_1.height;
            var _local_8:Boolean;
            if (_arg_2.x < 0)
            {
                _local_4 = _arg_2.x;
                _local_10 = (_local_10 - _local_4);
                _arg_2.x = 0;
                _local_8 = true;
            };
            if (_arg_2.right > _local_10)
            {
                _local_10 = (_arg_2.x + _arg_2.width);
                _local_8 = true;
            };
            if (_arg_2.y < 0)
            {
                _local_3 = _arg_2.y;
                _local_5 = (_local_5 - _local_3);
                _arg_2.y = 0;
                _local_8 = true;
            };
            if (_arg_2.bottom > _local_5)
            {
                _local_5 = (_arg_2.y + _arg_2.height);
                _local_8 = true;
            };
            if (_local_8)
            {
                _local_6 = (_arg_1.param & (0x020000 | 0x024000));
                if (_local_6)
                {
                    _arg_1.setParamFlag(_local_6, false);
                };
                _arg_1.setRectangle((_arg_1.x + _local_4), (_arg_1.y + _local_3), _local_10, _local_5);
                if (((!(_local_3 == 0)) || (!(_local_4 == 0))))
                {
                    var _local_7:uint = _arg_1.numChildren;
                    _local_9 = 0;
                    while (_local_9 < _local_7)
                    {
                        IWindow(_arg_1.getChildAt(_local_9)).offset(-(_local_4), -(_local_3));
                        _local_9++;
                    };
                };
                if (_local_6)
                {
                    _arg_1.setParamFlag(_local_6, true);
                };
            };
        }

        public static function resizeToAccommodateChildren(_arg_1:WindowController):void
        {
            var _local_11:IWindow;
            var _local_9:uint;
            var _local_7:uint;
            var _local_4:Boolean;
            var _local_3:int;
            var _local_2:int;
            var _local_5:int = -2147483648;
            var _local_10:int = -2147483648;
            var _local_8:Boolean;
            var _local_6:uint = _arg_1.numChildren;
            _local_9 = 0;
            while (_local_9 < _local_6)
            {
                _local_11 = _arg_1.getChildAt(_local_9);
                if ((_local_11.x + _local_11.width) > _local_5)
                {
                    _local_5 = (_local_11.x + _local_11.width);
                    _local_8 = true;
                };
                if ((_local_11.y + _local_11.height) > _local_10)
                {
                    _local_10 = (_local_11.y + _local_11.height);
                    _local_8 = true;
                };
                _local_9++;
            };
            if (_local_8)
            {
                _local_7 = (_arg_1.param & (0x020000 | 0x024000));
                if (_local_7)
                {
                    _arg_1.setParamFlag(_local_7, false);
                };
                if (((!(_local_3 == 0)) || (!(_local_2 == 0))))
                {
                    _local_9 = 0;
                    while (_local_9 < _local_6)
                    {
                        _local_11 = _arg_1.getChildAt(_local_9);
                        _local_4 = _local_11.testParamFlag(32);
                        if (_local_4)
                        {
                            _local_11.setParamFlag(32, false);
                        };
                        _local_11.offset(-(_local_3), -(_local_2));
                        if (_local_4)
                        {
                            _local_11.setParamFlag(32, true);
                        };
                        _local_9++;
                    };
                };
                _arg_1.width = _local_5;
                _arg_1.height = _local_10;
                if (_local_7)
                {
                    _arg_1.setParamFlag(_local_7, true);
                };
            };
        }


        public function get properties():Array
        {
            return ([]);
        }

        public function get procedure():Function
        {
            return ((_SafeStr_900 != null) ? _SafeStr_900 : ((_parent != null) ? _parent.procedure : nullEventProc));
        }

        public function get filters():Array
        {
            return ((hasGraphicsContext()) ? getGraphicContext(true).filters : []);
        }

        public function get parent():IWindow
        {
            return (_parent);
        }

        public function get debug():Boolean
        {
            return (_SafeStr_845);
        }

        public function get limits():IRectLimiter
        {
            return ((_SafeStr_1229) ? _SafeStr_1229 : _SafeStr_1229 = new WindowRectLimits(this));
        }

        public function get immediateClickMode():Boolean
        {
            return (_SafeStr_912);
        }

        public function set x(_arg_1:int):void
        {
            if (_arg_1 != _SafeStr_954)
            {
                setRectangle(_arg_1, _SafeStr_955, _SafeStr_908, _SafeStr_909);
            };
        }

        public function set y(_arg_1:int):void
        {
            if (_arg_1 != _SafeStr_955)
            {
                setRectangle(_SafeStr_954, _arg_1, _SafeStr_908, _SafeStr_909);
            };
        }

        public function set id(_arg_1:int):void
        {
            _SafeStr_698 = _arg_1;
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function set width(_arg_1:int):void
        {
            if (_arg_1 != _SafeStr_908)
            {
                setRectangle(_SafeStr_954, _SafeStr_955, _arg_1, _SafeStr_909);
            };
        }

        public function set height(_arg_1:int):void
        {
            if (_arg_1 != _SafeStr_909)
            {
                setRectangle(_SafeStr_954, _SafeStr_955, _SafeStr_908, _arg_1);
            };
        }

        public function set position(_arg_1:Point):void
        {
            setRectangle(_arg_1.x, _arg_1.y, _SafeStr_908, _SafeStr_909);
        }

        public function set rectangle(_arg_1:Rectangle):void
        {
            setRectangle(_arg_1.x, _arg_1.y, _arg_1.width, _arg_1.height);
        }

        public function set background(_arg_1:Boolean):void
        {
            _background = _arg_1;
            _fillColor = ((_background) ? (_fillColor | _alphaColor) : (_fillColor & 0xFFFFFF));
            _SafeStr_899 = ((_SafeStr_899) || (_arg_1));
            _context.invalidate(this, null, 1);
        }

        public function set color(_arg_1:uint):void
        {
            _alphaColor = (_arg_1 & 0xFF000000);
            _fillColor = ((_background) ? _arg_1 : (_arg_1 & 0xFFFFFF));
            _context.invalidate(this, null, 1);
        }

        public function set alpha(_arg_1:uint):void
        {
            _alphaColor = (_arg_1 << 24);
            _fillColor = ((_background) ? (_alphaColor | _fillColor) : (0xFFFFFF & _fillColor));
            _context.invalidate(this, null, 1);
        }

        public function set blend(_arg_1:Number):void
        {
            _arg_1 = ((_arg_1 > 1) ? 1 : ((_arg_1 < 0) ? 0 : _arg_1));
            if (_arg_1 != _SafeStr_1230)
            {
                _SafeStr_1230 = _arg_1;
                _context.invalidate(this, null, 16);
            };
        }

        public function set visible(_arg_1:Boolean):void
        {
            var _local_2:WindowEvent;
            if (_arg_1 != _SafeStr_898)
            {
                _SafeStr_898 = _arg_1;
                if (((_SafeStr_897) && (!(_arg_1))))
                {
                    _SafeStr_897.visible = false;
                };
                _context.invalidate(this, null, 1);
                _local_2 = WindowEvent.allocate("WE_CHILD_VISIBILITY", this, this);
                update(this, _local_2);
                _local_2.recycle();
            };
        }

        public function set type(_arg_1:uint):void
        {
            if (_arg_1 != _SafeStr_741)
            {
                _SafeStr_741 = _arg_1;
                _context.invalidate(this, null, 1);
            };
        }

        public function set caption(_arg_1:String):void
        {
            _arg_1 = ((_arg_1) ? _arg_1 : "");
            if (_arg_1 != caption)
            {
                _caption = _arg_1;
                _context.invalidate(this, null, 1);
            };
        }

        public function set tags(_arg_1:Array):void
        {
            if (_arg_1 != null)
            {
                _SafeStr_745 = _arg_1;
            };
        }

        public function set mouseThreshold(_arg_1:uint):void
        {
            _SafeStr_1239 = ((_arg_1 > 0xFF) ? 0xFF : _arg_1);
        }

        public function set procedure(_arg_1:Function):void
        {
            _SafeStr_900 = _arg_1;
        }

        public function set filters(_arg_1:Array):void
        {
            if (hasGraphicsContext())
            {
                getGraphicContext(true).filters = _arg_1;
            };
        }

        public function set debug(_arg_1:Boolean):void
        {
            _SafeStr_845 = _arg_1;
        }

        public function set properties(_arg_1:Array):void
        {
        }

        public function set offsetX(_arg_1:int):void
        {
            _offsetX = _arg_1;
        }

        public function set offsetY(_arg_1:int):void
        {
            _offsetY = _arg_1;
        }

        public function set etching(_arg_1:Array):void
        {
        }

        public function set state(_arg_1:uint):void
        {
            if (_arg_1 != _SafeStr_448)
            {
                _SafeStr_448 = _arg_1;
                _context.invalidate(this, null, 8);
            };
        }

        public function set dynamicStyleColor(_arg_1:ColorTransform):void
        {
            _SafeStr_1231 = _arg_1;
        }

        public function get dynamicStyleColor():ColorTransform
        {
            return (_SafeStr_1231);
        }

        public function set style(_arg_1:uint):void
        {
            var _local_2:Array;
            var _local_3:WindowController;
            var _local_4:uint;
            if (_arg_1 != _style)
            {
                _style = _arg_1;
                _local_2 = [];
                groupChildrenWithTag("_INTERNAL", _local_2);
                _local_4 = _local_2.length;
                while (--_local_4 > -1)
                {
                    _local_3 = (_local_2[_local_4] as WindowController);
                    if (_local_3.tags.indexOf("_IGNORE_INHERITED_STYLE") == -1)
                    {
                        _local_3.style = _style;
                    };
                };
                _context.invalidate(this, null, 1);
                _SafeStr_1237 = _context.getWindowFactory().getThemeManager().getPropertyDefaults(_style);
            };
        }

        public function set dynamicStyle(_arg_1:String):void
        {
            _SafeStr_1238 = _arg_1;
            _context.invalidate(this, null, 1);
        }

        public function set clipping(_arg_1:Boolean):void
        {
            if (_arg_1 != _SafeStr_1232)
            {
                _SafeStr_1232 = _arg_1;
                _context.invalidate(this, null, 1);
            };
        }

        public function get host():IWindow
        {
            return ((_parent == desktop) ? this : _parent.host);
        }

        public function get desktop():IDesktopWindow
        {
            return (_context.getDesktopWindow());
        }

        public function set parent(_arg_1:IWindow):void
        {
            var _local_3:WindowEvent;
            if (_arg_1 == this)
            {
                throw (new Error("Attempted to assign self as parent!"));
            };
            if (((!(_arg_1 == null)) && (!(_arg_1.context == _context))))
            {
                _context = WindowContext(_arg_1.context);
                if (_children)
                {
                    for each (var _local_4:WindowController in _children)
                    {
                        _local_4.parent = this;
                    };
                };
            };
            var _local_2:IWindow = _parent;
            if (_parent != _arg_1)
            {
                if (_parent != null)
                {
                    _parent.removeChild(this);
                };
                _parent = WindowController(_arg_1);
                if (_parent != null)
                {
                    _SafeStr_1233 = _parent.rectangle;
                    _SafeStr_1227.x = _SafeStr_954;
                    _SafeStr_1227.y = _SafeStr_955;
                    _SafeStr_1227.width = _SafeStr_908;
                    _SafeStr_1227.height = _SafeStr_909;
                    _local_3 = WindowEvent.allocate("WE_PARENT_ADDED", this, _parent);
                    update(this, _local_3);
                }
                else
                {
                    _SafeStr_1233.x = 0;
                    _SafeStr_1233.y = 0;
                    _SafeStr_1233.width = 0;
                    _SafeStr_1233.height = 0;
                    _local_3 = WindowEvent.allocate("WE_PARENT_REMOVED", this, _local_2);
                    update(this, _local_3);
                };
                _local_3.recycle();
            };
        }

        public function hasGraphicsContext():Boolean
        {
            return ((!(_SafeStr_897 == null)) || (!(testParamFlag(16))));
        }

        public function getGraphicContext(_arg_1:Boolean):IGraphicContext
        {
            if (((_arg_1) && (!(_SafeStr_897))))
            {
                _SafeStr_897 = new GraphicContext((("GC {" + _name) + "}"), 1, new Rectangle(_SafeStr_954, _SafeStr_955, _SafeStr_908, _SafeStr_909));
                _SafeStr_897.visible = _SafeStr_898;
            };
            return (_SafeStr_897);
        }

        public function setupGraphicsContext():IGraphicContext
        {
            var _local_1:int;
            _SafeStr_897 = getGraphicContext(true);
            if (_parent)
            {
                _parent.setupGraphicsContext();
            };
            if (((_children) && (_children.length > 0)))
            {
                if (_SafeStr_897.numChildContexts != numChildren)
                {
                    _local_1 = 0;
                    for each (var _local_2:WindowController in _children)
                    {
                        _SafeStr_897.addChildContextAt(_local_2.getGraphicContext(true), _local_1++);
                    };
                };
            };
            _SafeStr_1235 = true;
            return (_SafeStr_897);
        }

        public function releaseGraphicsContext():void
        {
            _SafeStr_1235 = false;
            if (_SafeStr_897)
            {
            };
        }

        public function clone():IWindow
        {
            var _local_2:Class = Object(this).constructor;
            var _local_1:WindowController = (new _local_2(_name, _SafeStr_741, _style, _SafeStr_1226, _context, new Rectangle(_SafeStr_954, _SafeStr_955, _SafeStr_908, _SafeStr_909), null, _SafeStr_900, properties, ((_SafeStr_745) ? _SafeStr_745.concat() : null), _SafeStr_698) as WindowController);
            _local_1.dynamicStyle = _SafeStr_1238;
            _local_1._SafeStr_1239 = _SafeStr_1239;
            _local_1._SafeStr_899 = _SafeStr_899;
            _local_1._SafeStr_845 = _SafeStr_845;
            _local_1._SafeStr_1233 = _SafeStr_1233.clone();
            _local_1._SafeStr_954 = _SafeStr_954;
            _local_1._SafeStr_955 = _SafeStr_955;
            _local_1._SafeStr_908 = _SafeStr_908;
            _local_1._SafeStr_909 = _SafeStr_909;
            _local_1._SafeStr_1225 = _SafeStr_1225.clone();
            _local_1._SafeStr_1227 = _SafeStr_1227.clone();
            _local_1._SafeStr_1240 = ((_SafeStr_1240) ? _SafeStr_1240.clone() : null);
            _local_1._SafeStr_1241 = ((_SafeStr_1241) ? _SafeStr_1241.clone() : null);
            _local_1._SafeStr_1229 = ((_SafeStr_1229) ? _SafeStr_1229.clone(_local_1) : null);
            _local_1._context = _context;
            _local_1._fillColor = _fillColor;
            _local_1._alphaColor = _alphaColor;
            _local_1.clipping = _SafeStr_1232;
            _local_1._SafeStr_898 = _SafeStr_898;
            _local_1._SafeStr_1230 = _SafeStr_1230;
            _local_1._SafeStr_1226 = _SafeStr_1226;
            _local_1._SafeStr_448 = _SafeStr_448;
            _local_1._name = _name;
            _local_1._SafeStr_698 = _SafeStr_698;
            _local_1.caption = _caption;
            _local_1.background = _background;
            cloneChildWindows(_local_1);
            return (_local_1);
        }

        protected function cloneChildWindows(_arg_1:WindowController):void
        {
            var _local_2:WindowController;
            if (_children)
            {
                for each (_local_2 in _children)
                {
                    if (_local_2.tags.indexOf("_EXCLUDE") == -1)
                    {
                        _arg_1.addChild(_local_2.clone());
                    };
                };
            };
        }

        override public function dispose():void
        {
            var _local_1:WindowDisposeEvent;
            if (!_disposed)
            {
                immediateClickMode = false;
                _SafeStr_900 = null;
                if (!_context.disposed)
                {
                    if (!isChildWindow())
                    {
                        if (getStateFlag(1))
                        {
                            deactivate();
                        };
                    };
                };
                if (_children)
                {
                    while (_children.length > 0)
                    {
                        IDisposable(_children.pop()).dispose();
                    };
                };
                _children = null;
                if (parent)
                {
                    parent = null;
                };
                if (_SafeStr_913)
                {
                    _local_1 = WindowDisposeEvent.allocate(this);
                    _SafeStr_913.dispatchEvent(_local_1);
                    _local_1.recycle();
                    if ((_SafeStr_913 is IDisposable))
                    {
                        IDisposable(_SafeStr_913).dispose();
                        _SafeStr_913 = null;
                    };
                };
                if (_SafeStr_897 != null)
                {
                    _SafeStr_897.dispose();
                    _SafeStr_897 = null;
                };
                super.dispose();
            };
        }

        public function toString():String
        {
            return (((((("[Window " + getQualifiedClassName(this)) + " ") + _name) + " ") + _SafeStr_1236) + "]");
        }

        override public function invalidate(_arg_1:Rectangle=null):void
        {
            _context.invalidate(this, _arg_1, 1);
        }

        public function resolve():uint
        {
            return (0);
        }

        public function center():void
        {
            if (_parent != null)
            {
                x = ((_parent.width / 2) - (_SafeStr_908 / 2));
                y = ((_parent.height / 2) - (_SafeStr_909 / 2));
            };
        }

        public function setRectangle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            var _local_7:uint;
            var _local_8:WindowEvent;
            if (_SafeStr_1229)
            {
                _arg_4 = Math.max(_SafeStr_1229.minHeight, _arg_4);
                _arg_4 = Math.min(_SafeStr_1229.maxHeight, _arg_4);
                _arg_3 = Math.max(_SafeStr_1229.minWidth, _arg_3);
                _arg_3 = Math.min(_SafeStr_1229.maxWidth, _arg_3);
            };
            var _local_5:Boolean = ((!(_arg_1 == _SafeStr_954)) || (!(_arg_2 == _SafeStr_955)));
            var _local_6:Boolean = ((!(_arg_3 == _SafeStr_908)) || (!(_arg_4 == _SafeStr_909)));
            if (((_local_6) && (!(_local_5))))
            {
                _local_7 = (_SafeStr_1226 & 0x0C0000);
                if (_local_7 == 0xC0000)
                {
                    _arg_1 = int((_arg_1 - ((_arg_3 - _SafeStr_908) / 2)));
                    _local_5 = true;
                }
                else
                {
                    if (_local_7 == 0x40000)
                    {
                        _arg_1 = (_arg_1 - (_arg_3 - _SafeStr_908));
                        _local_5 = true;
                    };
                };
                _local_7 = (_SafeStr_1226 & 0x300000);
                if (_local_7 == 0x300000)
                {
                    _arg_2 = int((_arg_2 - ((_arg_4 - _SafeStr_909) / 2)));
                    _local_5 = true;
                }
                else
                {
                    if (_local_7 == 0x100000)
                    {
                        _arg_2 = (_arg_2 - (_arg_4 - _SafeStr_909));
                        _local_5 = true;
                    };
                };
            };
            if (testParamFlag(32))
            {
                if (_parent != null)
                {
                    _arg_1 = ((_arg_1 < 0) ? 0 : _arg_1);
                    _arg_2 = ((_arg_2 < 0) ? 0 : _arg_2);
                    if (_local_5)
                    {
                        _arg_1 = (_arg_1 - (((_arg_1 + _arg_3) > _parent.width) ? ((_arg_1 + _arg_3) - _parent.width) : 0));
                        _arg_2 = (_arg_2 - (((_arg_2 + _arg_4) > _parent.height) ? ((_arg_2 + _arg_4) - _parent.height) : 0));
                        _local_5 = ((!(_arg_1 == _SafeStr_954)) || (!(_arg_2 == _SafeStr_955)));
                    }
                    else
                    {
                        _arg_3 = (_arg_3 - (((_arg_1 + _arg_3) > _parent.width) ? ((_arg_1 + _arg_3) - _parent.width) : 0));
                        _arg_4 = (_arg_4 - (((_arg_2 + _arg_4) > _parent.height) ? ((_arg_2 + _arg_4) - _parent.height) : 0));
                        _local_6 = ((!(_arg_3 == _SafeStr_908)) || (!(_arg_4 == _SafeStr_909)));
                    };
                };
            };
            if (((_local_5) || (_local_6)))
            {
                if (_local_5)
                {
                    _local_8 = WindowEvent.allocate("WE_RELOCATE", this, null, true);
                    update(this, _local_8);
                    if (_local_8.isWindowOperationPrevented())
                    {
                        _local_5 = false;
                    };
                    _local_8.recycle();
                };
                if (_local_6)
                {
                    _local_8 = WindowEvent.allocate("WE_RESIZE", this, null, true);
                    update(this, _local_8);
                    if (_local_8.isWindowOperationPrevented())
                    {
                        _local_6 = false;
                    };
                    _local_8.recycle();
                };
                if (_local_5)
                {
                    _SafeStr_1227.x = _SafeStr_954;
                    _SafeStr_1227.y = _SafeStr_955;
                    _SafeStr_1227.width = _SafeStr_908;
                    _SafeStr_1227.height = _SafeStr_909;
                    _SafeStr_954 = _arg_1;
                    _SafeStr_955 = _arg_2;
                };
                if (_local_6)
                {
                    _SafeStr_1227.width = _SafeStr_908;
                    _SafeStr_1227.height = _SafeStr_909;
                    _SafeStr_908 = _arg_3;
                    _SafeStr_909 = _arg_4;
                };
                if (_local_5)
                {
                    _local_8 = WindowEvent.allocate("WE_RELOCATED", this, null);
                    update(this, _local_8);
                    _local_8.recycle();
                };
                if (_local_6)
                {
                    _local_8 = WindowEvent.allocate("WE_RESIZED", this, null);
                    update(this, _local_8);
                    _local_8.recycle();
                };
            };
        }

        public function getRegionProperties(_arg_1:Rectangle=null, _arg_2:Rectangle=null, _arg_3:Rectangle=null, _arg_4:Rectangle=null):void
        {
            if (_arg_1 != null)
            {
                _arg_1.x = _SafeStr_954;
                _arg_1.y = _SafeStr_955;
                _arg_1.width = _SafeStr_908;
                _arg_1.height = _SafeStr_909;
            };
            if (_arg_2 != null)
            {
                _arg_2.x = _SafeStr_1227.x;
                _arg_2.y = _SafeStr_1227.y;
                _arg_2.width = _SafeStr_1227.width;
                _arg_2.height = _SafeStr_1227.height;
            };
            if (((!(_arg_3 == null)) && (!(_SafeStr_1240 == null))))
            {
                _arg_3.x = _SafeStr_1240.x;
                _arg_3.y = _SafeStr_1240.y;
                _arg_3.width = _SafeStr_1240.width;
                _arg_3.height = _SafeStr_1240.height;
            };
            if (((!(_arg_4 == null)) && (!(_SafeStr_1241 == null))))
            {
                _arg_4.x = _SafeStr_1241.x;
                _arg_4.y = _SafeStr_1241.y;
                _arg_4.width = _SafeStr_1241.width;
                _arg_4.height = _SafeStr_1241.height;
            };
        }

        public function setRegionProperties(_arg_1:Rectangle=null, _arg_2:Rectangle=null, _arg_3:Rectangle=null):void
        {
            if (_arg_3 != null)
            {
                if (((_arg_3.width < 0) || (_arg_3.height < 0)))
                {
                    throw (new Error("Invalid rectangle; maximized size can't be less than zero!"));
                };
                if (_SafeStr_1241 == null)
                {
                    _SafeStr_1241 = new Rectangle();
                };
                _SafeStr_1241.x = _arg_3.x;
                _SafeStr_1241.y = _arg_3.y;
                _SafeStr_1241.width = _arg_3.width;
                _SafeStr_1241.height = _arg_3.height;
            };
            if (_arg_2 != null)
            {
                if (((_arg_2.width < 0) || (_arg_2.height < 0)))
                {
                    throw (new Error("Invalid rectangle; minimized size can't be less than zero!"));
                };
                if (_SafeStr_1240 == null)
                {
                    _SafeStr_1240 = new Rectangle();
                };
                _SafeStr_1240.x = _arg_2.x;
                _SafeStr_1240.y = _arg_2.y;
                _SafeStr_1240.width = _arg_2.width;
                _SafeStr_1240.height = _arg_2.height;
            };
            if (((_arg_3.width < _arg_2.width) || (_arg_3.height < _arg_2.height)))
            {
                _arg_3.width = _arg_2.width;
                _arg_3.height = _arg_2.height;
                throw (new Error("Maximized rectangle can't be smaller than minimized rectangle!"));
            };
            if (_arg_1 != null)
            {
                setRectangle(_arg_1.x, _arg_1.y, _arg_1.width, _arg_1.height);
            };
        }

        public function buildFromXML(_arg_1:XML, _arg_2:Map=null):Boolean
        {
            return (!(_context.getWindowParser().parseAndConstruct(_arg_1, this, _arg_2) == null));
        }

        public function fetchDrawBuffer():IBitmapDrawable
        {
            return ((testParamFlag(16)) ? ((_parent != null) ? _parent.fetchDrawBuffer() : null) : getGraphicContext(true).fetchDrawBuffer());
        }

        public function getDrawRegion(_arg_1:Rectangle):void
        {
            if (!testParamFlag(16))
            {
                _arg_1.x = 0;
                _arg_1.y = 0;
                _arg_1.width = _SafeStr_908;
                _arg_1.height = _SafeStr_909;
            }
            else
            {
                if (_parent != null)
                {
                    _parent.getDrawRegion(_arg_1);
                    _arg_1.x = (_arg_1.x + _SafeStr_954);
                    _arg_1.y = (_arg_1.y + _SafeStr_955);
                    _arg_1.width = _SafeStr_908;
                    _arg_1.height = _SafeStr_909;
                }
                else
                {
                    _arg_1.x = 0;
                    _arg_1.y = 0;
                    _arg_1.width = 0;
                    _arg_1.height = 0;
                };
            };
        }

        public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_5:IMouseListenerService;
            var _local_6:IWindow;
            var _local_4:WindowEvent;
            var _local_3:uint;
            if (!testParamFlag(9))
            {
                procedure(_arg_2, this);
                if (_disposed)
                {
                    return (true);
                };
                if (!_arg_2.isWindowOperationPrevented())
                {
                    if (hasEventListener(_arg_2.type))
                    {
                        _SafeStr_913.dispatchEvent(_arg_2);
                        if (_disposed)
                        {
                            return (true);
                        };
                    };
                };
                if (_arg_2.cancelable)
                {
                    if (_arg_2.isWindowOperationPrevented())
                    {
                        return (true);
                    };
                };
            };
            if ((_arg_2 is WindowMouseEvent))
            {
                switch (_arg_2.type)
                {
                    case "WME_DOWN":
                        if (activate())
                        {
                            if (_arg_2.cancelable)
                            {
                                _arg_2.preventDefault();
                            };
                        };
                        if (disposed)
                        {
                            return (true);
                        };
                        setStateFlag(16, true);
                        _local_5 = _context.getWindowServices().getMouseListenerService();
                        _local_5.begin(this);
                        _local_5.eventTypes.push("WME_UP");
                        _local_5.areaLimit = 3;
                        if (testParamFlag(0x0101))
                        {
                            _local_6 = this;
                            while (_local_6 != null)
                            {
                                if (_local_6.testParamFlag(0x8000))
                                {
                                    _context.getWindowServices().getMouseDraggingService().begin(_local_6);
                                    break;
                                };
                                _local_6 = _local_6.parent;
                            };
                        };
                        if ((_SafeStr_1226 & 0x3000) > 0)
                        {
                            _local_6 = this;
                            while (_local_6 != null)
                            {
                                if (_local_6.testParamFlag(0x10000))
                                {
                                    _context.getWindowServices().getMouseScalingService().begin(_local_6, (_SafeStr_1226 & 0x3000));
                                    break;
                                };
                                _local_6 = _local_6.parent;
                            };
                        };
                        break;
                    case "WME_UP":
                        if (testStateFlag(16))
                        {
                            setStateFlag(16, false);
                        };
                        _context.getWindowServices().getMouseListenerService().end(this);
                        if (testParamFlag(0x8000))
                        {
                            _context.getWindowServices().getMouseDraggingService().end(this);
                        };
                        if (testParamFlag(0x10000))
                        {
                            _context.getWindowServices().getMouseScalingService().end(this);
                        };
                        break;
                    case "WME_OUT":
                        if (testStateFlag(4))
                        {
                            setStateFlag(4, false);
                        };
                        if (testStateFlag(16))
                        {
                            setStateFlag(16, false);
                        };
                        break;
                    case "WME_OVER":
                        if (!testStateFlag(4))
                        {
                            setStateFlag(4, true);
                        };
                        break;
                    case "WME_WHEEL":
                        return (false);
                };
            }
            else
            {
                if ((_arg_2 is WindowEvent))
                {
                    switch (_arg_2.type)
                    {
                        case "WE_RESIZED":
                            if (_arg_1 == this)
                            {
                                _SafeStr_1228.x = ((_SafeStr_954 < _SafeStr_1227.x) ? _SafeStr_954 : _SafeStr_1227.x);
                                _SafeStr_1228.y = ((_SafeStr_955 < _SafeStr_1227.y) ? _SafeStr_955 : _SafeStr_1227.y);
                                _SafeStr_1228.right = (((_SafeStr_954 + _SafeStr_908) > _SafeStr_1227.right) ? (_SafeStr_954 + _SafeStr_908) : _SafeStr_1227.right);
                                _SafeStr_1228.bottom = (((_SafeStr_955 + _SafeStr_909) > _SafeStr_1227.bottom) ? (_SafeStr_955 + _SafeStr_909) : _SafeStr_1227.bottom);
                                _SafeStr_1228.offset(-(_SafeStr_954), -(_SafeStr_955));
                                _context.invalidate(this, _SafeStr_1228, 2);
                                _local_4 = WindowEvent.allocate("WE_PARENT_RESIZED", this, null);
                                notifyChildren(_local_4);
                                _local_4.recycle();
                                if (testParamFlag(192, 192))
                                {
                                    updateScaleRelativeToParent();
                                }
                                else
                                {
                                    if (testParamFlag(0x0C00, 0x0C00))
                                    {
                                        updateScaleRelativeToParent();
                                    };
                                };
                                if (_parent != null)
                                {
                                    _local_3 = _SafeStr_1226;
                                    _SafeStr_1226 = (_SafeStr_1226 & 0xFFFFF33F);
                                    if (testParamFlag(0x400000))
                                    {
                                        _parent.width = (_parent.width + (_SafeStr_908 - _SafeStr_1227.width));
                                    };
                                    if (testParamFlag(0x800000))
                                    {
                                        _parent.height = (_parent.height + (_SafeStr_909 - _SafeStr_1227.height));
                                    };
                                    _SafeStr_1226 = _local_3;
                                    _local_4 = WindowEvent.allocate("WE_CHILD_RESIZED", _parent, this);
                                    _parent.update(this, _local_4);
                                    _local_4.recycle();
                                };
                            };
                            break;
                        case "WE_RELOCATED":
                            if (_arg_1 == this)
                            {
                                _SafeStr_1228.x = ((_SafeStr_954 < _SafeStr_1227.x) ? _SafeStr_954 : _SafeStr_1227.x);
                                _SafeStr_1228.y = ((_SafeStr_955 < _SafeStr_1227.y) ? _SafeStr_955 : _SafeStr_1227.y);
                                _SafeStr_1228.right = (((_SafeStr_954 + _SafeStr_908) > _SafeStr_1227.right) ? (_SafeStr_954 + _SafeStr_908) : _SafeStr_1227.right);
                                _SafeStr_1228.bottom = (((_SafeStr_955 + _SafeStr_909) > _SafeStr_1227.bottom) ? (_SafeStr_955 + _SafeStr_909) : _SafeStr_1227.bottom);
                                _SafeStr_1228.offset(-(_SafeStr_954), -(_SafeStr_955));
                                _context.invalidate(this, _SafeStr_1228, 4);
                                _local_4 = WindowEvent.allocate("WE_PARENT_RELOCATED", this, null);
                                notifyChildren(_local_4);
                                _local_4.recycle();
                                if (_parent != null)
                                {
                                    _local_4 = WindowEvent.allocate("WE_CHILD_RELOCATED", _parent, this);
                                    _parent.update(this, _local_4);
                                    _local_4.recycle();
                                };
                            };
                            break;
                        case "WE_ACTIVATED":
                            if (_arg_1 == this)
                            {
                                _local_4 = WindowEvent.allocate("WE_PARENT_ACTIVATED", this, null);
                                notifyChildren(_local_4);
                                _local_4.recycle();
                                if (_parent != null)
                                {
                                    _local_4 = WindowEvent.allocate("WE_CHILD_ACTIVATED", _parent, this);
                                    _parent.update(this, _local_4);
                                    _local_4.recycle();
                                };
                            };
                            break;
                        case "WE_PARENT_ADDED":
                            if (testParamFlag(192, 192))
                            {
                                updateScaleRelativeToParent();
                            }
                            else
                            {
                                if (testParamFlag(0x0C00, 0x0C00))
                                {
                                    updateScaleRelativeToParent();
                                };
                            };
                            _context.invalidate(this, null, 1);
                            break;
                        case "WE_PARENT_RESIZED":
                            _parent.getRegionProperties(null, _SafeStr_1233);
                            updateScaleRelativeToParent();
                            break;
                        case "WE_CHILD_ADDED":
                            if (testParamFlag(147456))
                            {
                                scaleToAccommodateChildren();
                            }
                            else
                            {
                                if (testParamFlag(0x20000))
                                {
                                    expandToAccommodateChild(this, _arg_2.related);
                                };
                            };
                            renderDynamicStyle();
                            break;
                        case "WE_CHILD_REMOVED":
                            if (testParamFlag(147456))
                            {
                                scaleToAccommodateChildren();
                            };
                            break;
                        case "WE_CHILD_ACTIVATED":
                            activate();
                            break;
                        case "WE_CHILD_RESIZED":
                            if (testParamFlag(147456))
                            {
                                scaleToAccommodateChildren();
                            }
                            else
                            {
                                if (testParamFlag(0x20000))
                                {
                                    expandToAccommodateChild(this, _arg_2.related);
                                };
                            };
                            break;
                        case "WE_CHILD_RELOCATED":
                            if (testParamFlag(147456))
                            {
                                scaleToAccommodateChildren();
                            }
                            else
                            {
                                if (testParamFlag(0x20000))
                                {
                                    expandToAccommodateChild(this, _arg_2.related);
                                };
                            };
                            break;
                        case "WE_CHILD_VISIBILITY":
                            if (_arg_1 == this)
                            {
                                if (_parent != null)
                                {
                                    _local_4 = WindowEvent.allocate("WE_CHILD_VISIBILITY", _parent, this);
                                    _parent.update(this, _local_4);
                                    _local_4.recycle();
                                };
                            };
                    };
                };
            };
            return (true);
        }

        private function renderDynamicStyle():void
        {
            var _local_1:uint;
            if (_SafeStr_1238 == "")
            {
                return;
            };
            if (((!(_SafeStr_1234)) || (!(_SafeStr_1234.name == _SafeStr_1238))))
            {
                _SafeStr_1234 = DynamicStyleManager.getStyle(_SafeStr_1238);
            };
            if (getStateFlag(32))
            {
                _local_1 = 32;
            }
            else
            {
                if (getStateFlag(16))
                {
                    _local_1 = 16;
                }
                else
                {
                    if (getStateFlag(4))
                    {
                        _local_1 = 4;
                    }
                    else
                    {
                        _local_1 = 0;
                    };
                };
            };
            applyDynamicStyleByState(this, _SafeStr_1234, _local_1);
            if (_children)
            {
                recursivelyUpdateChildrensDynamicStyles(_children, _local_1);
            };
        }

        private function applyDynamicStyleByState(_arg_1:WindowController, _arg_2:DynamicStyle, _arg_3:uint):void
        {
            var _local_5:Array;
            var _local_4:Object = _arg_2.getStyleByWindowState(_arg_3);
            _arg_1.offsetX = ((_local_4.offsetX) ? _local_4.offsetX : 0);
            _arg_1.offsetY = ((_local_4.offsetY) ? _local_4.offsetY : 0);
            if (_arg_1.hasGraphicsContext())
            {
                _arg_1._SafeStr_897.getDisplayObject().transform.colorTransform = _arg_2.getColorTransform(_arg_3);
            }
            else
            {
                _arg_1._SafeStr_1231 = _arg_2.getColorTransform(_arg_3);
                _arg_1.invalidate();
            };
            if (_local_4.etchingPoint)
            {
                _local_5 = [_local_4.etchingColor, _local_4.etchingPoint[0], _local_4.etchingPoint[1]];
                _arg_1.etching = _local_5;
                _arg_1.invalidate();
            }
            else
            {
                _arg_1.etching = [0, 0, 1];
                _arg_1.invalidate();
            };
        }

        private function recursivelyUpdateChildrensDynamicStyles(_arg_1:Vector.<IWindow>, _arg_2:uint):void
        {
            for each (var _local_3:WindowController in _arg_1)
            {
                if (_SafeStr_1234.getChildStyle(_local_3))
                {
                    applyDynamicStyleByState(_local_3, _SafeStr_1234.getChildStyle(_local_3), _arg_2);
                };
                if (_local_3._children)
                {
                    recursivelyUpdateChildrensDynamicStyles(_local_3._children, _arg_2);
                };
            };
        }

        protected function notifyEventListeners(_arg_1:WindowEvent):void
        {
            procedure(_arg_1, this);
            if (!_arg_1.isWindowOperationPrevented())
            {
                if (hasEventListener(_arg_1.type))
                {
                    _SafeStr_913.dispatchEvent(_arg_1);
                };
            };
        }

        private function nullEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
        }

        private function notifyChildren(_arg_1:WindowEvent):void
        {
            if (_children)
            {
                for each (var _local_2:WindowController in _children)
                {
                    _local_2.update(this, _arg_1);
                };
            };
        }

        public function convertPointFromGlobalToLocalSpace(_arg_1:Point):void
        {
            var _local_2:Number = _arg_1.x;
            var _local_3:Number = _arg_1.y;
            if (_parent == null)
            {
                _arg_1.x = _SafeStr_954;
                _arg_1.y = _SafeStr_955;
            }
            else
            {
                _parent.getGlobalPosition(_arg_1);
                _arg_1.x = (_arg_1.x + _SafeStr_954);
                _arg_1.y = (_arg_1.y + _SafeStr_955);
            };
            _arg_1.x = (_local_2 - _arg_1.x);
            _arg_1.y = (_local_3 - _arg_1.y);
        }

        public function convertPointFromLocalToGlobalSpace(_arg_1:Point):void
        {
            var _local_2:Number = _arg_1.x;
            var _local_3:Number = _arg_1.y;
            if (_parent == null)
            {
                _arg_1.x = _SafeStr_954;
                _arg_1.y = _SafeStr_955;
            }
            else
            {
                _parent.getGlobalPosition(_arg_1);
                _arg_1.x = (_arg_1.x + _SafeStr_954);
                _arg_1.y = (_arg_1.y + _SafeStr_955);
            };
            _arg_1.x = (_arg_1.x + _local_2);
            _arg_1.y = (_arg_1.y + _local_3);
        }

        public function getRelativeMousePosition(_arg_1:Point):void
        {
            getGlobalPosition(_arg_1);
            _arg_1.x = (_context.getDesktopWindow().mouseX - _arg_1.x);
            _arg_1.y = (_context.getDesktopWindow().mouseY - _arg_1.y);
        }

        public function getAbsoluteMousePosition(_arg_1:Point):void
        {
            _arg_1.x = _context.getDesktopWindow().mouseX;
            _arg_1.y = _context.getDesktopWindow().mouseY;
        }

        public function getLocalPosition(_arg_1:Point):void
        {
            _arg_1.x = _SafeStr_954;
            _arg_1.y = _SafeStr_955;
        }

        public function getLocalRectangle(_arg_1:Rectangle):void
        {
            _arg_1.x = _SafeStr_954;
            _arg_1.y = _SafeStr_955;
            _arg_1.width = _SafeStr_908;
            _arg_1.height = _SafeStr_909;
        }

        public function hitTestLocalPoint(_arg_1:Point):Boolean
        {
            return ((((_arg_1.x >= _SafeStr_954) && (_arg_1.x < (_SafeStr_954 + _SafeStr_908))) && (_arg_1.y >= _SafeStr_955)) && (_arg_1.y < (_SafeStr_955 + _SafeStr_909)));
        }

        public function hitTestLocalRectangle(_arg_1:Rectangle):Boolean
        {
            return (rectangle.intersects(_arg_1));
        }

        public function validateLocalPointIntersection(_arg_1:Point, _arg_2:BitmapData):Boolean
        {
            return (testLocalPointHitAgainstAlpha(_arg_1, _arg_2, _SafeStr_1239));
        }

        public function getGlobalPosition(_arg_1:Point):void
        {
            if (_parent != null)
            {
                _parent.getGlobalPosition(_arg_1);
                _arg_1.x = (_arg_1.x + _SafeStr_954);
                _arg_1.y = (_arg_1.y + _SafeStr_955);
            }
            else
            {
                _arg_1.x = _SafeStr_954;
                _arg_1.y = _SafeStr_955;
            };
        }

        public function setGlobalPosition(_arg_1:Point):void
        {
            var _local_2:Point = new Point();
            if (_parent != null)
            {
                _parent.getGlobalPosition(_local_2);
                _local_2.x = (_local_2.x + _SafeStr_954);
                _local_2.y = (_local_2.y + _SafeStr_955);
            }
            else
            {
                _local_2.x = _SafeStr_954;
                _local_2.y = _SafeStr_955;
            };
            x = (x + (_arg_1.x - _local_2.x));
            y = (y + (_arg_1.y - _local_2.y));
        }

        public function getGlobalRectangle(_arg_1:Rectangle):void
        {
            if (_parent != null)
            {
                _parent.getGlobalRectangle(_arg_1);
                _arg_1.x = (_arg_1.x + _SafeStr_954);
                _arg_1.y = (_arg_1.y + _SafeStr_955);
            }
            else
            {
                _arg_1.x = _SafeStr_954;
                _arg_1.y = _SafeStr_955;
            };
            _arg_1.width = _SafeStr_908;
            _arg_1.height = _SafeStr_909;
        }

        public function setGlobalRectangle(_arg_1:Rectangle):void
        {
            var _local_2:Point = new Point();
            if (_parent != null)
            {
                _parent.getGlobalPosition(_local_2);
                _local_2.x = (_local_2.x + _SafeStr_954);
                _local_2.y = (_local_2.y + _SafeStr_955);
            }
            else
            {
                _local_2.x = _SafeStr_954;
                _local_2.y = _SafeStr_955;
            };
            setRectangle((x + (_arg_1.x - _local_2.x)), (y + (_arg_1.y - _local_2.y)), _arg_1.width, _arg_1.height);
        }

        public function hitTestGlobalPoint(_arg_1:Point):Boolean
        {
            var _local_2:Rectangle = new Rectangle();
            getGlobalRectangle(_local_2);
            return (_local_2.containsPoint(_arg_1));
        }

        public function hitTestGlobalRectangle(_arg_1:Rectangle):Boolean
        {
            var _local_2:Rectangle = new Rectangle();
            getGlobalRectangle(_local_2);
            return (_local_2.intersects(_arg_1));
        }

        public function validateGlobalPointIntersection(_arg_1:Point, _arg_2:BitmapData):Boolean
        {
            var _local_3:Point = new Point();
            getGlobalPosition(_local_3);
            _local_3.x = (_arg_1.x - _local_3.x);
            _local_3.y = (_arg_1.y - _local_3.y);
            return (testLocalPointHitAgainstAlpha(_local_3, _arg_2, _SafeStr_1239));
        }

        public function getMouseRegion(_arg_1:Rectangle):void
        {
            var _local_2:Rectangle;
            getGlobalRectangle(_arg_1);
            if (_arg_1.width < 0)
            {
                _arg_1.width = 0;
            };
            if (_arg_1.height < 0)
            {
                _arg_1.height = 0;
            };
            if (testParamFlag(16))
            {
                _local_2 = new Rectangle();
                IWindow(_parent).getMouseRegion(_local_2);
                if (_arg_1.left < _local_2.left)
                {
                    _arg_1.left = _local_2.left;
                };
                if (_arg_1.top < _local_2.top)
                {
                    _arg_1.top = _local_2.top;
                };
                if (_arg_1.right > _local_2.right)
                {
                    _arg_1.right = _local_2.right;
                };
                if (_arg_1.bottom > _local_2.bottom)
                {
                    _arg_1.bottom = _local_2.bottom;
                };
            };
        }

        protected function testLocalPointHitAgainstAlpha(_arg_1:Point, _arg_2:BitmapData, _arg_3:uint):Boolean
        {
            var _local_4:BitmapData;
            var _local_5:Boolean;
            if (((_SafeStr_908 < 1) || (_SafeStr_909 < 1)))
            {
                return (false);
            };
            if (((_SafeStr_899) && (_SafeStr_1239 > 0)))
            {
                if (!testParamFlag(16))
                {
                    if (((_arg_1.x <= _SafeStr_908) && (_arg_1.y <= _SafeStr_909)))
                    {
                        _local_4 = (getGraphicContext(true).fetchDrawBuffer() as BitmapData);
                        if (_local_4 != null)
                        {
                            _local_5 = _local_4.hitTest(_POINT_ZERO, _arg_3, _arg_1);
                        };
                    };
                }
                else
                {
                    _local_5 = ((_arg_2 != null) ? _arg_2.hitTest(_POINT_ZERO, _arg_3, _arg_1) : false);
                };
            }
            else
            {
                if (((_arg_1.x >= 0) && (_arg_1.x < _SafeStr_908)))
                {
                    if (((_arg_1.y >= 0) && (_arg_1.y < _SafeStr_909)))
                    {
                        _local_5 = true;
                    };
                };
            };
            return (_local_5);
        }

        public function isCapableOfUsingSharedGraphicContext():Boolean
        {
            return (true);
        }

        public function resolveVerticalScale():Number
        {
            return (_SafeStr_909 / _SafeStr_1225.height);
        }

        public function resolveHorizontalScale():Number
        {
            return (_SafeStr_908 / _SafeStr_1225.width);
        }

        public function offset(_arg_1:Number, _arg_2:Number):void
        {
            setRectangle((_SafeStr_954 + _arg_1), (_SafeStr_955 + _arg_2), _SafeStr_908, _SafeStr_909);
        }

        public function scale(_arg_1:Number, _arg_2:Number):void
        {
            setRectangle(_SafeStr_954, _SafeStr_955, (_SafeStr_908 + _arg_1), (_SafeStr_909 + _arg_2));
        }

        public function scaleToAccommodateChildren():void
        {
            var _local_9:IWindow;
            var _local_8:Array;
            var _local_6:uint;
            if (!_children)
            {
                return;
            };
            var _local_2:int;
            var _local_1:int;
            var _local_7:int;
            var _local_3:int;
            var _local_5:Boolean;
            var _local_4:uint = (param & (0x020000 | 0x024000));
            for each (_local_9 in _children)
            {
                if (_local_9.x < _local_2)
                {
                    _local_7 = (_local_7 - (_local_9.x - _local_2));
                    _local_2 = _local_9.x;
                    _local_5 = true;
                };
                if ((_local_9.x + _local_9.width) > _local_7)
                {
                    _local_7 = (_local_9.x + _local_9.width);
                    _local_5 = true;
                };
                if (_local_9.y < _local_1)
                {
                    _local_3 = (_local_3 - (_local_9.y - _local_1));
                    _local_1 = _local_9.y;
                    _local_5 = true;
                };
                if ((_local_9.y + _local_9.height) > _local_3)
                {
                    _local_3 = (_local_9.y + _local_9.height);
                    _local_5 = true;
                };
            };
            if (_local_5)
            {
                _local_8 = [];
                for each (_local_9 in _children)
                {
                    _local_6 = (_local_9.param & (0xC0 | 0x0C00));
                    _local_9.setParamFlag(_local_6, false);
                    _local_8.push(_local_6);
                };
                if (_local_4)
                {
                    setParamFlag(_local_4, false);
                };
                setRectangle((_SafeStr_954 + _local_2), (_SafeStr_955 + _local_1), _local_7, _local_3);
                for each (_local_9 in _children)
                {
                    _local_9.offset(-(_local_2), -(_local_1));
                    _local_9.setParamFlag(_local_8.shift(), true);
                };
                if (_local_4)
                {
                    setParamFlag(_local_4, true);
                };
            };
        }

        public function getStateFlag(_arg_1:uint):Boolean
        {
            return (!((_SafeStr_448 & _arg_1) == 0));
        }

        public function setStateFlag(_arg_1:uint, _arg_2:Boolean=true):void
        {
            var _local_4:uint;
            var _local_3:uint = _SafeStr_448;
            _SafeStr_448 = ((_arg_2) ? ((_local_4 = (_SafeStr_448 | _arg_1)), (_SafeStr_448 = _local_4), _local_4) : ((_local_4 = (_SafeStr_448 & (~(_arg_1)))), (_SafeStr_448 = _local_4), _local_4));
            if (_SafeStr_448 != _local_3)
            {
                renderDynamicStyle();
                _context.invalidate(this, null, 8);
            };
        }

        public function getStyleFlag(_arg_1:uint):Boolean
        {
            return (!((_style & _arg_1) == 0));
        }

        public function setStyleFlag(_arg_1:uint, _arg_2:Boolean=true):void
        {
            var _local_7:uint;
            var _local_3:Array;
            var _local_4:WindowController;
            var _local_6:uint;
            var _local_5:uint = _style;
            _style = ((_arg_2) ? ((_local_7 = (_style | _arg_1)), (_style = _local_7), _local_7) : ((_local_7 = (_style & (~(_arg_1)))), (_style = _local_7), _local_7));
            if (_style != _local_5)
            {
                _local_3 = [];
                groupChildrenWithTag("_INTERNAL", _local_3);
                _local_6 = _local_3.length;
                while (--_local_6 > -1)
                {
                    _local_4 = (_local_3[_local_6] as WindowController);
                    if (_local_4.tags.indexOf("_IGNORE_INHERITED_STYLE") == -1)
                    {
                        _local_4.style = _style;
                    };
                };
                _context.invalidate(this, null, 1);
            };
        }

        public function getParamFlag(_arg_1:uint):Boolean
        {
            return (!((_SafeStr_1226 & _arg_1) == 0));
        }

        public function setParamFlag(_arg_1:uint, _arg_2:Boolean=true):void
        {
            var _local_4:uint;
            var _local_3:uint = _SafeStr_1226;
            _SafeStr_1226 = ((_arg_2) ? ((_local_4 = (_SafeStr_1226 | _arg_1)), (_SafeStr_1226 = _local_4), _local_4) : ((_local_4 = (_SafeStr_1226 & (~(_arg_1)))), (_SafeStr_1226 = _local_4), _local_4));
            if (_SafeStr_1226 != _local_3)
            {
                if (!(_SafeStr_1226 & 0x10))
                {
                    if (!_SafeStr_897)
                    {
                        setupGraphicsContext();
                        _context.invalidate(this, null, 1);
                    };
                }
                else
                {
                    if ((_SafeStr_1226 & 0x10))
                    {
                        if (_SafeStr_897)
                        {
                            _context.invalidate(this, null, 1);
                        };
                    };
                };
            };
        }

        protected function updateScaleRelativeToParent():void
        {
            var _local_9:uint;
            var _local_2:uint;
            var _local_6:int;
            if (_parent == null)
            {
                return;
            };
            var _local_1:Boolean = (!(testParamFlag(0, 192)));
            var _local_8:Boolean = (!(testParamFlag(0, 0x0C00)));
            var _local_4:int = _SafeStr_954;
            var _local_7:int = _SafeStr_955;
            var _local_3:int = _SafeStr_908;
            var _local_5:int = _SafeStr_909;
            if (((_local_1) || (_local_8)))
            {
                if (_local_1)
                {
                    _local_6 = (_parent.width - _SafeStr_1233.width);
                    _local_9 = (_SafeStr_1226 & 0xC0);
                    if (_local_9 == 128)
                    {
                        _local_3 = (_local_3 + _local_6);
                    }
                    else
                    {
                        if (_local_9 == 64)
                        {
                            _local_4 = (_local_4 + _local_6);
                        }
                        else
                        {
                            if (_local_9 == 192)
                            {
                                if (((_parent.width < _local_3) && (getParamFlag(16))))
                                {
                                    _local_4 = 0;
                                }
                                else
                                {
                                    _local_4 = int((Math.floor((_parent.width / 2)) - Math.floor((_local_3 / 2))));
                                };
                            };
                        };
                    };
                };
                if (_local_8)
                {
                    _local_6 = (_parent.height - _SafeStr_1233.height);
                    _local_9 = (_SafeStr_1226 & 0x0C00);
                    if (_local_9 == 0x0800)
                    {
                        _local_5 = (_local_5 + _local_6);
                    }
                    else
                    {
                        if (_local_9 == 0x0400)
                        {
                            _local_7 = (_local_7 + _local_6);
                        }
                        else
                        {
                            if (_local_9 == 0x0C00)
                            {
                                if (((_parent.height < _local_5) && (getParamFlag(16))))
                                {
                                    _local_7 = 0;
                                }
                                else
                                {
                                    _local_7 = int((Math.floor((_parent.height / 2)) - Math.floor((_local_5 / 2))));
                                };
                            };
                        };
                    };
                };
                _local_2 = _SafeStr_1226;
                _SafeStr_1226 = (_SafeStr_1226 & 0xFF3FF33F);
                setRectangle(_local_4, _local_7, _local_3, _local_5);
                _SafeStr_1226 = _local_2;
            }
            else
            {
                if (testParamFlag(32))
                {
                    if (_parent != null)
                    {
                        _local_4 = ((_local_4 < 0) ? 0 : _local_4);
                        _local_7 = ((_local_7 < 0) ? 0 : _local_7);
                        _local_4 = (_local_4 - (((_local_4 + _local_3) > _parent.width) ? ((_local_4 + _local_3) - _parent.width) : 0));
                        _local_7 = (_local_7 - (((_local_7 + _local_5) > _parent.height) ? ((_local_7 + _local_5) - _parent.height) : 0));
                        _local_3 = (_local_3 - (((_local_4 + _local_3) > _parent.width) ? ((_local_4 + _local_3) - _parent.width) : 0));
                        _local_5 = (_local_5 - (((_local_7 + _local_5) > _parent.height) ? ((_local_7 + _local_5) - _parent.height) : 0));
                        if (((((!(_local_4 == _SafeStr_954)) || (!(_local_7 == _SafeStr_955))) || (!(_local_3 == _SafeStr_908))) || (!(_local_5 == _SafeStr_909))))
                        {
                            _local_2 = _SafeStr_1226;
                            _SafeStr_1226 = (_SafeStr_1226 & 0xFF3FF33F);
                            setRectangle(_local_4, _local_7, _local_3, _local_5);
                            _SafeStr_1226 = _local_2;
                        };
                    };
                };
            };
        }

        protected function isChildWindow():Boolean
        {
            return (!(_parent == context.getDesktopWindow()));
        }

        public function destroy():Boolean
        {
            if (_SafeStr_448 == 0x40000000)
            {
                return (true);
            };
            _SafeStr_448 = 0x40000000;
            var _local_1:WindowEvent = WindowEvent.allocate("WE_DESTROY", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            _local_1 = WindowEvent.allocate("WE_DESTROYED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            dispose();
            return (true);
        }

        public function minimize():Boolean
        {
            if ((_SafeStr_448 & 0x40))
            {
                return (false);
            };
            var _local_1:WindowEvent = WindowEvent.allocate("WE_MINIMIZE", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            setStateFlag(64, true);
            _local_1 = WindowEvent.allocate("WE_MINIMIZED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function maximize():Boolean
        {
            if ((_SafeStr_448 & 0x40))
            {
                return (false);
            };
            var _local_1:WindowEvent = WindowEvent.allocate("WE_MAXIMIZE", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            setStateFlag(64, true);
            _local_1 = WindowEvent.allocate("WE_MAXIMIZED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function restore():Boolean
        {
            var _local_1:WindowEvent = WindowEvent.allocate("WE_RESTORE", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            setStateFlag(64, false);
            _local_1 = WindowEvent.allocate("WE_RESTORED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function activate():Boolean
        {
            var _local_1:WindowEvent = WindowEvent.allocate("WE_ACTIVATE", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            setStateFlag(1, true);
            _local_1 = WindowEvent.allocate("WE_ACTIVATED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function deactivate():Boolean
        {
            if (!getStateFlag(1))
            {
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate("WE_DEACTIVATE", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            setStateFlag(1, false);
            _local_1 = WindowEvent.allocate("WE_DEACTIVATED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function lock():Boolean
        {
            if (getStateFlag(64))
            {
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate("WE_LOCK", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            setStateFlag(64, true);
            _local_1 = WindowEvent.allocate("WE_LOCKED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function unlock():Boolean
        {
            if (!getStateFlag(64))
            {
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate("WE_UNLOCK", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            setStateFlag(64, false);
            _local_1 = WindowEvent.allocate("WE_UNLOCKED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function enable():Boolean
        {
            if (!getStateFlag(32))
            {
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate("WE_ENABLE", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            setStateFlag(32, false);
            _local_1 = WindowEvent.allocate("WE_ENABLED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function disable():Boolean
        {
            if (getStateFlag(32))
            {
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate("WE_DISABLE", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            setStateFlag(32, true);
            _local_1 = WindowEvent.allocate("WE_DISABLED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function focus():Boolean
        {
            if (getStateFlag(2))
            {
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate("WE_FOCUS", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            setStateFlag(2, true);
            _local_1 = WindowEvent.allocate("WE_FOCUSED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function unfocus():Boolean
        {
            if (!getStateFlag(2))
            {
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate("WE_UNFOCUS", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            setStateFlag(2, false);
            _local_1 = WindowEvent.allocate("WE_UNFOCUSED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function getChildUnderPoint(_arg_1:Point):IWindow
        {
            var _local_3:Rectangle;
            var _local_5:IWindow;
            var _local_4:Boolean;
            if (_SafeStr_898)
            {
                _local_3 = new Rectangle();
                getMouseRegion(_local_3);
                _local_4 = _local_3.containsPoint(_arg_1);
                var _local_2:uint = numChildren;
                if (_local_4)
                {
                    while (_local_2 > 0)
                    {
                        _local_5 = WindowController(_children[(_local_2 - 1)]).getChildUnderPoint(_arg_1);
                        if (_local_5 != null)
                        {
                            return (_local_5);
                        };
                        _local_2--;
                    };
                };
                if (validateGlobalPointIntersection(_arg_1, null))
                {
                    return (this);
                };
            };
            return (null);
        }

        public function groupChildrenUnderPoint(_arg_1:Point, _arg_2:Array):void
        {
            var _local_3:WindowController;
            if (_SafeStr_898)
            {
                if (((((_arg_1.x >= _SafeStr_954) && (_arg_1.x < (_SafeStr_954 + _SafeStr_908))) && (_arg_1.y >= _SafeStr_955)) && (_arg_1.y < (_SafeStr_955 + _SafeStr_909))))
                {
                    _arg_2.push(this);
                    if (_children)
                    {
                        _arg_1.offset(-(_SafeStr_954), -(_SafeStr_955));
                        for each (_local_3 in _children)
                        {
                            _local_3.groupChildrenUnderPoint(_arg_1, _arg_2);
                        };
                        _arg_1.offset(_SafeStr_954, _SafeStr_955);
                    };
                }
                else
                {
                    if (!_SafeStr_1232)
                    {
                        if (_children)
                        {
                            _arg_1.offset(-(_SafeStr_954), -(_SafeStr_955));
                            for each (_local_3 in _children)
                            {
                                _local_3.groupChildrenUnderPoint(_arg_1, _arg_2);
                            };
                            _arg_1.offset(_SafeStr_954, _SafeStr_955);
                        };
                    };
                };
            };
        }

        public function groupParameterFilteredChildrenUnderPoint(_arg_1:Point, _arg_2:Array, _arg_3:uint=0):void
        {
            var _local_4:WindowController;
            if (_SafeStr_898)
            {
                if (((((_arg_1.x >= _SafeStr_954) && (_arg_1.x < (_SafeStr_954 + _SafeStr_908))) && (_arg_1.y >= _SafeStr_955)) && (_arg_1.y < (_SafeStr_955 + _SafeStr_909))))
                {
                    if ((_SafeStr_1226 & _arg_3) == _arg_3)
                    {
                        _arg_2.push(this);
                    };
                    if (_children)
                    {
                        _arg_1.offset(-(_SafeStr_954), -(_SafeStr_955));
                        for each (_local_4 in _children)
                        {
                            _local_4.groupParameterFilteredChildrenUnderPoint(_arg_1, _arg_2, _arg_3);
                        };
                        _arg_1.offset(_SafeStr_954, _SafeStr_955);
                    };
                }
                else
                {
                    if (!_SafeStr_1232)
                    {
                        if (_children)
                        {
                            _arg_1.offset(-(_SafeStr_954), -(_SafeStr_955));
                            for each (_local_4 in _children)
                            {
                                _local_4.groupParameterFilteredChildrenUnderPoint(_arg_1, _arg_2, _arg_3);
                            };
                            _arg_1.offset(_SafeStr_954, _SafeStr_955);
                        };
                    };
                };
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:int=0):void
        {
            if (!_disposed)
            {
                if (!_SafeStr_913)
                {
                    _SafeStr_913 = new WindowEventDispatcher(this);
                };
                _SafeStr_913.addEventListener(_arg_1, _arg_2, _arg_3);
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (((_disposed) || (!(_SafeStr_913))) ? false : _SafeStr_913.hasEventListener(_arg_1));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function):void
        {
            if (((!(_disposed)) && (_SafeStr_913)))
            {
                _SafeStr_913.removeEventListener(_arg_1, _arg_2);
            };
        }

        public function get children():Vector.<IWindow>
        {
            return (_children);
        }

        public function get numChildren():int
        {
            return ((_children) ? _children.length : 0);
        }

        public function populate(_arg_1:Array):void
        {
            var _local_2:Boolean;
            if (!_children)
            {
                _children = new Vector.<IWindow>();
            };
            for each (var _local_3:WindowController in _arg_1)
            {
                if (((_local_3) && (!(_local_3.parent == this))))
                {
                    _children.push(_local_3);
                    _local_3.parent = this;
                    _local_2 = ((_local_2) || (_local_3.hasGraphicsContext()));
                };
            };
            if (((_SafeStr_1235) || (_local_2)))
            {
                setupGraphicsContext();
            };
        }

        public function addChild(_arg_1:IWindow):IWindow
        {
            var _local_2:WindowController = WindowController(_arg_1);
            if (_local_2.parent != null)
            {
                WindowController(_local_2.parent).removeChild(_local_2);
            };
            if (!_children)
            {
                _children = new Vector.<IWindow>();
            };
            _children.push(_local_2);
            _local_2.parent = this;
            if (((_SafeStr_1235) || (_local_2.hasGraphicsContext())))
            {
                setupGraphicsContext();
                if (_local_2.getGraphicContext(true).parent != _SafeStr_897)
                {
                    _SafeStr_897.addChildContext(_local_2.getGraphicContext(true));
                };
            };
            var _local_3:WindowEvent = WindowEvent.allocate("WE_CHILD_ADDED", this, _arg_1);
            update(this, _local_3);
            _local_3.recycle();
            return (_arg_1);
        }

        public function addChildAt(_arg_1:IWindow, _arg_2:int):IWindow
        {
            var _local_3:WindowController = WindowController(_arg_1);
            if (_local_3.parent != null)
            {
                WindowController(_local_3.parent).removeChild(_local_3);
            };
            if (!_children)
            {
                _children = new Vector.<IWindow>();
            };
            _children.splice(_arg_2, 0, _local_3);
            _local_3.parent = this;
            if (((_SafeStr_1235) || (_local_3.hasGraphicsContext())))
            {
                setupGraphicsContext();
                if (_local_3.getGraphicContext(true).parent != _SafeStr_897)
                {
                    _SafeStr_897.addChildContextAt(_local_3.getGraphicContext(true), _arg_2);
                };
            };
            var _local_4:WindowEvent = WindowEvent.allocate("WE_CHILD_ADDED", this, _arg_1);
            update(this, _local_4);
            _local_4.recycle();
            return (_arg_1);
        }

        public function getChildAt(_arg_1:int):IWindow
        {
            return ((_children) ? (((_arg_1 < _children.length) && (_arg_1 > -1)) ? _children[_arg_1] : null) : null);
        }

        public function getChildByID(_arg_1:int):IWindow
        {
            if (_children)
            {
                for each (var _local_2:IWindow in _children)
                {
                    if (_local_2.id == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        public function getChildByName(_arg_1:String):IWindow
        {
            if (_children)
            {
                for each (var _local_2:IWindow in _children)
                {
                    if (_local_2.name == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        public function findChildByName(_arg_1:String):IWindow
        {
            var _local_2:WindowController;
            if (_children)
            {
                for each (_local_2 in _children)
                {
                    if (_local_2.name == _arg_1)
                    {
                        return (_local_2);
                    };
                };
                for each (_local_2 in _children)
                {
                    _local_2 = (_local_2.findChildByName(_arg_1) as WindowController);
                    if (_local_2)
                    {
                        return (_local_2 as IWindow);
                    };
                };
            };
            return (null);
        }

        public function getChildByTag(_arg_1:String):IWindow
        {
            if (_children)
            {
                for each (var _local_2:IWindow in _children)
                {
                    if (_local_2.tags.indexOf(_arg_1) > -1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        public function findChildByTag(_arg_1:String):IWindow
        {
            if (((_SafeStr_745) && (_SafeStr_745.indexOf(_arg_1) > -1)))
            {
                return (this);
            };
            var _local_2:WindowController = WindowController(getChildByTag(_arg_1));
            if (((_local_2 == null) && (_children)))
            {
                for each (_local_2 in _children)
                {
                    _local_2 = (_local_2.findChildByTag(_arg_1) as WindowController);
                    if (_local_2 != null) break;
                };
            };
            return (_local_2 as IWindow);
        }

        public function getChildIndex(_arg_1:IWindow):int
        {
            return ((_children) ? _children.indexOf(_arg_1) : -1);
        }

        public function removeChild(_arg_1:IWindow):IWindow
        {
            if (!_children)
            {
                return (null);
            };
            var _local_3:int = _children.indexOf(_arg_1);
            if (_local_3 < 0)
            {
                return (null);
            };
            _children.splice(_local_3, 1);
            _arg_1.parent = null;
            var _local_2:IGraphicContextHost = (_arg_1 as IGraphicContextHost);
            if (((_local_2) && (_local_2.hasGraphicsContext())))
            {
                _SafeStr_897.removeChildContext(_local_2.getGraphicContext(true));
            };
            var _local_4:WindowEvent = WindowEvent.allocate("WE_CHILD_REMOVED", this, _arg_1);
            update(this, _local_4);
            _local_4.recycle();
            return (_arg_1);
        }

        public function removeChildAt(_arg_1:int):IWindow
        {
            return (removeChild(getChildAt(_arg_1)));
        }

        public function setChildIndex(_arg_1:IWindow, _arg_2:int):void
        {
            var _local_4:WindowController;
            if (!_children)
            {
                return;
            };
            var _local_3:int = _children.indexOf(_arg_1);
            if (((_local_3 > -1) && (!(_arg_2 == _local_3))))
            {
                _children.splice(_local_3, 1);
                _children.splice(_arg_2, 0, _arg_1);
                _local_4 = WindowController(_arg_1);
                if (_local_4.hasGraphicsContext())
                {
                    _SafeStr_897.setChildContextIndex(_local_4.getGraphicContext(true), getChildIndex(_local_4));
                };
            };
        }

        public function swapChildren(_arg_1:IWindow, _arg_2:IWindow):void
        {
            var _local_3:int;
            var _local_6:int;
            var _local_5:IWindow = null;
            var _local_4:int;
            if (!_children)
            {
                return;
            };
            if ((((!(_arg_1 == null)) && (!(_arg_2 == null))) && (!(_arg_1 == _arg_2))))
            {
                _local_3 = _children.indexOf(_arg_1);
                if (_local_3 < 0)
                {
                    return;
                };
                _local_6 = _children.indexOf(_arg_2);
                if (_local_6 < 0)
                {
                    return;
                };
                if (_local_6 < _local_3)
                {
                    _local_5 = _arg_1;
                    _arg_1 = _arg_2;
                    _arg_2 = _local_5;
                    _local_4 = _local_3;
                    _local_3 = _local_6;
                    _local_6 = _local_4;
                };
                _children.splice(_local_6, 1);
                _children.splice(_local_3, 1);
                _children.splice(_local_3, 0, _arg_2);
                _children.splice(_local_6, 0, _arg_1);
                if (((WindowController(_arg_1).hasGraphicsContext()) || (WindowController(_arg_2).hasGraphicsContext())))
                {
                    _SafeStr_897.swapChildContexts(WindowController(_arg_1).getGraphicContext(true), WindowController(_arg_2).getGraphicContext(true));
                };
            };
        }

        public function swapChildrenAt(_arg_1:int, _arg_2:int):void
        {
            if (!_children)
            {
                return;
            };
            swapChildren(_children[_arg_1], _children[_arg_2]);
            _SafeStr_897.swapChildContextsAt(_arg_1, _arg_2);
        }

        public function groupChildrenWithID(_arg_1:uint, _arg_2:Array, _arg_3:int=0):uint
        {
            var _local_5:WindowController;
            if (!_children)
            {
                return (0);
            };
            var _local_4:uint;
            for each (_local_5 in _children)
            {
                if (_local_5.id == _arg_1)
                {
                    _arg_2.push(_local_5);
                    _local_4++;
                };
                if (((_arg_3 > 0) || (_arg_3 < 0)))
                {
                    _local_4 = (_local_4 + _local_5.groupChildrenWithID(_arg_1, _arg_2, --_arg_3));
                };
            };
            return (_local_4);
        }

        public function groupChildrenWithTag(_arg_1:String, _arg_2:Array, _arg_3:int=0):uint
        {
            var _local_5:WindowController;
            if (!_children)
            {
                return (0);
            };
            var _local_4:uint;
            for each (_local_5 in _children)
            {
                if (_local_5.tags.indexOf(_arg_1) > -1)
                {
                    _arg_2.push(_local_5);
                    _local_4++;
                };
                if (((_arg_3 > 0) || (_arg_3 < 0)))
                {
                    _local_4 = (_local_4 + _local_5.groupChildrenWithTag(_arg_1, _arg_2, (_arg_3 - 1)));
                };
            };
            return (_local_4);
        }

        public function findParentByName(_arg_1:String):IWindow
        {
            if (_name == _arg_1)
            {
                return (this);
            };
            if (_parent != null)
            {
                if (_parent.name == _arg_1)
                {
                    return (_parent);
                };
                return (_parent.findParentByName(_arg_1));
            };
            return (null);
        }

        protected function requiresOwnGraphicContext():Boolean
        {
            var _local_1:WindowController;
            if (testParamFlag(16))
            {
                if (_children)
                {
                    for each (_local_1 in _children)
                    {
                        if (_local_1.requiresOwnGraphicContext())
                        {
                            return (true);
                        };
                    };
                };
                return (false);
            };
            return (true);
        }

        public function createProperty(_arg_1:String, _arg_2:Object):PropertyStruct
        {
            return (_SafeStr_1237.get(_arg_1).withValue(_arg_2));
        }

        public function getDefaultProperty(_arg_1:String):PropertyStruct
        {
            return (_SafeStr_1237.get(_arg_1));
        }

        public function isEnabled():Boolean
        {
            return (!(getStateFlag(32)));
        }

        public function enableChildren(_arg_1:Boolean, _arg_2:Array):void
        {
            var _local_4:IWindow;
            for each (var _local_3:String in _arg_2)
            {
                _local_4 = this.findChildByName(_local_3);
                if (_local_4 != null)
                {
                    if (_arg_1)
                    {
                        _local_4.enable();
                    }
                    else
                    {
                        _local_4.disable();
                    };
                };
            };
        }

        public function activateChildren(_arg_1:Boolean, _arg_2:Array):void
        {
            var _local_4:IWindow;
            for each (var _local_3:String in _arg_2)
            {
                _local_4 = this.findChildByName(_local_3);
                if (_local_4 != null)
                {
                    if (_arg_1)
                    {
                        _local_4.activate();
                    }
                    else
                    {
                        _local_4.deactivate();
                    };
                };
            };
        }

        public function setVisibleChildren(_arg_1:Boolean, _arg_2:Array):void
        {
            var _local_4:IWindow;
            for each (var _local_3:String in _arg_2)
            {
                _local_4 = this.findChildByName(_local_3);
                if (_local_4 != null)
                {
                    _local_4.visible = _arg_1;
                };
            };
        }

        public function set immediateClickMode(_arg_1:Boolean):void
        {
            var _local_2:IGraphicContext;
            if (_arg_1 != _SafeStr_912)
            {
                _SafeStr_912 = _arg_1;
                _local_2 = getGraphicContext(false);
                if (_local_2)
                {
                    if (_SafeStr_912)
                    {
                        _local_2.mouse = true;
                        _local_2.addEventListener("click", immediateClickHandler);
                    }
                    else
                    {
                        _local_2.mouse = false;
                        _local_2.removeEventListener("click", immediateClickHandler);
                    };
                };
            };
        }

        protected function immediateClickHandler(_arg_1:Event):void
        {
            var _local_5:IWindow;
            var _local_2:MouseEvent = (_arg_1 as MouseEvent);
            var _local_6:Point = new Point(_local_2.stageX, _local_2.stageY);
            var _local_3:Array = [];
            desktop.groupChildrenUnderPoint(_local_6, _local_3);
            while (_local_3.length > 0)
            {
                _local_5 = _local_3.pop();
                if (_local_5 == this) break;
                if (_local_5.getParamFlag(1))
                {
                    return;
                };
            };
            getRelativeMousePosition(_local_6);
            var _local_4:WindowEvent = WindowMouseEvent.allocate("WME_CLICK", this, null, _local_6.x, _local_6.y, _local_2.stageX, _local_2.stageY, _local_2.altKey, _local_2.ctrlKey, _local_2.shiftKey, _local_2.buttonDown, _local_2.delta);
            if (_SafeStr_913)
            {
                _SafeStr_913.dispatchEvent(_local_4);
            };
            if (!_local_4.isWindowOperationPrevented())
            {
                if (procedure != null)
                {
                    procedure(_local_4, this);
                };
            };
            _arg_1.stopImmediatePropagation();
            _local_4.recycle();
        }


    }
}

