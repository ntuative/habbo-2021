package com.sulake.core.window.graphics
{
    import flash.display.Sprite;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    import flash.display.Shape;
    import flash.display.Bitmap;
    import flash.text.TextField;
    import flash.display.MorphShape;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.IBitmapDrawable;
    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;

    public class GraphicContext extends Sprite implements IGraphicContext 
    {

        public static const _SafeStr_1117:uint = 0;
        public static const GC_TYPE_BITMAP:uint = 1;
        public static const _SafeStr_1118:uint = 2;
        public static const GC_TYPE_CONTAINER:uint = 4;
        public static const GC_TYPE_SHAPE:uint = 8;
        public static const GC_TYPE_MORPH_SHAPE:uint = 16;
        public static const _SafeStr_1119:uint = 64;
        public static const _SafeStr_1120:uint = 128;
        public static const _SafeStr_1121:uint = 0x0100;

        protected static var _SafeStr_795:uint = 0;
        protected static var _SafeStr_1122:uint = 0;

        protected var _SafeStr_1123:DisplayObjectContainer;
        protected var _useAlpha:Boolean;
        protected var _SafeStr_1124:Boolean;
        protected var _disposed:Boolean = false;
        protected var _rectangle:Rectangle;
        protected var _mask:Shape;

        public function GraphicContext(_arg_1:String, _arg_2:uint, _arg_3:Rectangle)
        {
            super();
            var _local_4:TextField = null;
            _SafeStr_795++;
            if (_arg_3 == null)
            {
                _arg_3 = new Rectangle(0, 0, 0, 0);
            };
            this.name = _arg_1;
            this.mouseEnabled = false;
            this.doubleClickEnabled = false;
            this.x = _arg_3.x;
            this.y = _arg_3.y;
            _rectangle = _arg_3;
            _useAlpha = true;
            _SafeStr_1124 = false;
            switch (_arg_2)
            {
                case 1:
                    _SafeStr_1124 = true;
                    setDisplayObject(new Bitmap());
                    allocateDrawBuffer(_arg_3.width, _arg_3.height);
                    return;
                case 2:
                    _local_4 = new TextField();
                    _local_4.width = _arg_3.width;
                    _local_4.height = _arg_3.height;
                    _local_4.type = "input";
                    setDisplayObject(_local_4);
                    return;
                case 8:
                    setDisplayObject(new Shape());
                    return;
                case 16:
                    setDisplayObject(new MorphShape());
                    return;
                case 4:
                    setDisplayObject(new Sprite());
                    return;
                case 0x0100:
                    return;
                case 0:
                    return;
                default:
                    throw (new Error((("Unsupported graphic context type: " + _arg_2) + "!")));
            };
        }

        public static function get numGraphicContexts():uint
        {
            return (_SafeStr_795);
        }

        public static function get allocatedByteCount():uint
        {
            return (_SafeStr_1122);
        }


        public function set parent(_arg_1:DisplayObjectContainer):void
        {
            if (parent != null)
            {
                parent.removeChild(this);
            };
            if (_arg_1 != null)
            {
                _arg_1.addChild(this);
            };
        }

        public function offSet(_arg_1:Point):void
        {
            this.x = _arg_1.x;
            this.y = _arg_1.y;
        }

        override public function get filters():Array
        {
            return (getDisplayObject().filters);
        }

        override public function set filters(_arg_1:Array):void
        {
            getDisplayObject().filters = _arg_1;
        }

        public function get blend():Number
        {
            return (this.alpha);
        }

        public function set blend(_arg_1:Number):void
        {
            this.alpha = _arg_1;
        }

        public function get mouse():Boolean
        {
            return (super.mouseEnabled);
        }

        public function set mouse(_arg_1:Boolean):void
        {
            super.mouseEnabled = _arg_1;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (parent != null)
                {
                    parent.removeChild(this);
                    parent = null;
                };
                while (numChildContexts > 0)
                {
                    removeChildContextAt(0);
                };
                if (_SafeStr_1124)
                {
                    releaseDrawBuffer();
                };
                if (_SafeStr_1123 != null)
                {
                    while (_SafeStr_1123.numChildren > 0)
                    {
                        _SafeStr_1123.removeChildAt(0);
                    };
                };
                _SafeStr_1123 = null;
                while (numChildren > 0)
                {
                    removeChildAt(0);
                };
                _mask = null;
                _disposed = true;
                _SafeStr_795--;
            };
        }

        override public function toString():String
        {
            return (('[object GraphicContext name="' + name) + '"]');
        }

        public function getDrawRegion():Rectangle
        {
            return (_rectangle.clone());
        }

        public function setDrawRegion(_arg_1:Rectangle, _arg_2:Boolean, _arg_3:Rectangle):BitmapData
        {
            var _local_4:BitmapData;
            if (((_SafeStr_1124) && (_arg_2)))
            {
                _local_4 = allocateDrawBuffer(_arg_1.width, _arg_1.height);
            };
            x = _arg_1.x;
            y = _arg_1.y;
            _rectangle.x = _arg_1.x;
            _rectangle.y = _arg_1.y;
            _rectangle.width = _arg_1.width;
            _rectangle.height = _arg_1.height;
            if (_arg_3)
            {
                if (!_mask)
                {
                    _mask = new Shape();
                    _mask.visible = false;
                    super.addChild(_mask);
                };
                _mask.graphics.clear();
                _mask.graphics.beginFill(0xFF);
                _mask.graphics.drawRect(_arg_3.x, _arg_3.y, _arg_3.width, _arg_3.height);
                _mask.graphics.endFill();
                getDisplayObject().mask = _mask;
            }
            else
            {
                if (_mask)
                {
                    super.removeChild(_mask);
                    _mask.graphics.clear();
                    _mask = null;
                    getDisplayObject().mask = null;
                };
            };
            return (_local_4);
        }

        public function getDisplayObject():DisplayObject
        {
            return (getChildAt(0));
        }

        public function setDisplayObject(_arg_1:DisplayObject):DisplayObject
        {
            var _local_2:DisplayObject;
            if (numChildren > 0)
            {
                _local_2 = removeChildAt(0);
            };
            addChildAt(_arg_1, 0);
            _arg_1.mask = _mask;
            return (_local_2);
        }

        public function getAbsoluteMousePosition(_arg_1:Point):void
        {
            _arg_1.x = stage.mouseX;
            _arg_1.y = stage.mouseY;
        }

        public function getRelativeMousePosition(_arg_1:Point):void
        {
            var _local_2:DisplayObject = getDisplayObject();
            _arg_1.x = _local_2.mouseX;
            _arg_1.y = _local_2.mouseY;
        }

        public function fetchDrawBuffer():IBitmapDrawable
        {
            var _local_1:Bitmap;
            if (_SafeStr_1124)
            {
                _local_1 = (getDisplayObject() as Bitmap);
                if (_local_1)
                {
                    return (_local_1.bitmapData);
                };
            };
            return (null);
        }

        protected function allocateDrawBuffer(_arg_1:int, _arg_2:int):BitmapData
        {
            var _local_3:Bitmap;
            var _local_4:BitmapData;
            if (_SafeStr_1124)
            {
                _local_3 = (getDisplayObject() as Bitmap);
                if (_local_3)
                {
                    _local_4 = _local_3.bitmapData;
                    if (_local_4 != null)
                    {
                        if (((!(_local_4.width == _arg_1)) || (!(_local_4.height == _arg_2))))
                        {
                            _local_3.bitmapData = null;
                            _SafeStr_1122 = (_SafeStr_1122 - ((_local_4.width * _local_4.height) * 4));
                            _local_4.dispose();
                            _local_4 = null;
                        };
                    };
                    if ((((_local_4 == null) && (_arg_1 > 0)) && (_arg_2 > 0)))
                    {
                        _local_4 = new TrackedBitmapData(this, _arg_1, _arg_2, _useAlpha, 0xFFFFFF);
                        _SafeStr_1122 = (_SafeStr_1122 + ((_local_4.width * _local_4.height) * 4));
                        _local_3.bitmapData = _local_4;
                    };
                    return (_local_4);
                };
            };
            return (null);
        }

        protected function releaseDrawBuffer():void
        {
            var _local_1:Bitmap;
            var _local_2:BitmapData;
            if (_SafeStr_1124)
            {
                _local_1 = (getDisplayObject() as Bitmap);
                if (_local_1)
                {
                    _local_2 = _local_1.bitmapData;
                    if (_local_2 != null)
                    {
                        _local_1.bitmapData = null;
                        _SafeStr_1122 = (_SafeStr_1122 - ((_local_2.width * _local_2.height) * 4));
                        _local_2.dispose();
                    };
                };
            };
        }

        public function showRedrawRegion(_arg_1:Rectangle):void
        {
            graphics.clear();
            graphics.lineStyle(1, 0xFF00FF00);
            graphics.drawRect(0, 0, width, height);
            if (_arg_1 != null)
            {
                graphics.lineStyle(1, 0xFF0000FF);
                graphics.drawRect(_arg_1.x, _arg_1.y, _arg_1.width, _arg_1.height);
            };
        }

        protected function setupChildContainer():DisplayObjectContainer
        {
            if (_SafeStr_1123 == null)
            {
                _SafeStr_1123 = new Sprite();
                _SafeStr_1123.name = (this.name + " - Child Container");
                _SafeStr_1123.mouseEnabled = false;
                addChild(_SafeStr_1123);
            };
            return (_SafeStr_1123);
        }

        protected function removeChildContainer():void
        {
            if (_SafeStr_1123 != null)
            {
                removeChild(_SafeStr_1123);
                _SafeStr_1123 = null;
            };
        }

        public function get numChildContexts():int
        {
            return ((_SafeStr_1123 != null) ? _SafeStr_1123.numChildren : 0);
        }

        public function addChildContext(_arg_1:IGraphicContext):IGraphicContext
        {
            return (setupChildContainer().addChild((_arg_1 as DisplayObject)) as IGraphicContext);
        }

        public function addChildContextAt(_arg_1:IGraphicContext, _arg_2:int):IGraphicContext
        {
            return (setupChildContainer().addChildAt((_arg_1 as DisplayObject), _arg_2) as IGraphicContext);
        }

        public function getChildContextAt(_arg_1:int):IGraphicContext
        {
            return (setupChildContainer().getChildAt(_arg_1) as IGraphicContext);
        }

        public function getChildContextByName(_arg_1:String):IGraphicContext
        {
            return (setupChildContainer().getChildByName(_arg_1) as IGraphicContext);
        }

        public function getChildContextIndex(_arg_1:IGraphicContext):int
        {
            return (setupChildContainer().getChildIndex(DisplayObject(_arg_1)));
        }

        public function removeChildContext(_arg_1:IGraphicContext):IGraphicContext
        {
            return (setupChildContainer().removeChild(DisplayObject(_arg_1)) as IGraphicContext);
        }

        public function removeChildContextAt(_arg_1:int):IGraphicContext
        {
            var _local_2:IGraphicContext = (setupChildContainer().getChildAt(_arg_1) as IGraphicContext);
            return ((_local_2 == null) ? null : removeChildContext(_local_2));
        }

        public function setChildContextIndex(_arg_1:IGraphicContext, _arg_2:int):void
        {
            var _local_4:int;
            var _local_5:Array;
            var _local_6:uint;
            var _local_3:DisplayObject = (_arg_1 as DisplayObject);
            if (_local_3 != null)
            {
                try
                {
                    _local_4 = setupChildContainer().getChildIndex(_local_3);
                }
                catch(error:ArgumentError)
                {
                    _local_5 = [];
                    _local_6 = 0;
                    while (_local_6 < numChildContexts)
                    {
                        _local_5.push(getChildContextAt(_local_6));
                        _local_6++;
                    };
                    throw (new Error("Provided display object is not a child of this!"));
                };
                if (_arg_2 != _local_4)
                {
                    setupChildContainer().setChildIndex(_local_3, _arg_2);
                };
            }
            else
            {
                throw (new Error("Provided child must implement IGraphicContext!"));
            };
        }

        public function swapChildContexts(_arg_1:IGraphicContext, _arg_2:IGraphicContext):void
        {
            setupChildContainer().swapChildren((_arg_1 as DisplayObject), (_arg_2 as DisplayObject));
        }

        public function swapChildContextsAt(_arg_1:int, _arg_2:int):void
        {
            setupChildContainer().swapChildrenAt(_arg_1, _arg_2);
        }


    }
}

