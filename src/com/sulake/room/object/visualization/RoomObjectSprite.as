package com.sulake.room.object.visualization
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.room.object.enum.RoomObjectSpriteType;

    public final class RoomObjectSprite implements IRoomObjectSprite 
    {

        private static var _SafeStr_4460:int = 0;

        private var _asset:BitmapData = null;
        private var _assetName:String = "";
        private var _libraryAssetName:String = "";
        private var _assetPosture:String = null;
        private var _assetGesture:String = null;
        private var _visible:Boolean = true;
        private var _tag:String = "";
        private var _alpha:int = 0xFF;
        private var _color:int = 0xFFFFFF;
        private var _blendMode:String = "normal";
        private var _flipH:Boolean = false;
        private var _flipV:Boolean = false;
        private var _direction:int = 0;
        private var _offset:Point = new Point(0, 0);
        private var _width:int = 0;
        private var _height:int = 0;
        private var _relativeDepth:Number = 0;
        private var _planeId:int = 0;
        private var _varyingDepth:Boolean = false;
        private var _alphaTolerance:int = 128;
        private var _clickHandling:Boolean = false;
        private var _updateId:int = 0;
        private var _instanceId:int = 0;
        private var _filters:Array = null;
        protected var _SafeStr_4461:int = RoomObjectSpriteType.DEFAULT;
        private var _objectType:String;

        public function RoomObjectSprite()
        {
            _instanceId = _SafeStr_4460++;
        }

        public function dispose():void
        {
            _asset = null;
            _width = 0;
            _height = 0;
        }

        public function get asset():BitmapData
        {
            return (_asset);
        }

        public function get assetName():String
        {
            return (_assetName);
        }

        public function get assetPosture():String
        {
            return (_assetPosture);
        }

        public function set assetPosture(_arg_1:String):void
        {
            _assetPosture = _arg_1;
        }

        public function get assetGesture():String
        {
            return (_assetGesture);
        }

        public function set assetGesture(_arg_1:String):void
        {
            _assetGesture = _arg_1;
        }

        public function get visible():Boolean
        {
            return (_visible);
        }

        public function get tag():String
        {
            return (_tag);
        }

        public function get alpha():int
        {
            return (_alpha);
        }

        public function get color():int
        {
            return (_color);
        }

        public function get blendMode():String
        {
            return (_blendMode);
        }

        public function get flipV():Boolean
        {
            return (_flipV);
        }

        public function get flipH():Boolean
        {
            return (_flipH);
        }

        public function get direction():int
        {
            return (_direction);
        }

        public function get offsetX():int
        {
            return (_offset.x);
        }

        public function get offsetY():int
        {
            return (_offset.y);
        }

        public function get width():int
        {
            return (_width);
        }

        public function get height():int
        {
            return (_height);
        }

        public function get relativeDepth():Number
        {
            return (_relativeDepth);
        }

        public function get varyingDepth():Boolean
        {
            return (_varyingDepth);
        }

        public function get clickHandling():Boolean
        {
            return (_clickHandling);
        }

        public function get instanceId():int
        {
            return (_instanceId);
        }

        public function get updateId():int
        {
            return (_updateId);
        }

        public function get filters():Array
        {
            return (_filters);
        }

        public function get spriteType():int
        {
            return (_SafeStr_4461);
        }

        public function get objectType():String
        {
            return (_objectType);
        }

        public function set objectType(_arg_1:String):void
        {
            _objectType = _arg_1;
        }

        public function get planeId():int
        {
            return (_planeId);
        }

        public function set planeId(_arg_1:int):void
        {
            _planeId = _arg_1;
        }

        public function set spriteType(_arg_1:int):void
        {
            _SafeStr_4461 = _arg_1;
        }

        public function set asset(_arg_1:BitmapData):void
        {
            if (_arg_1 == _asset)
            {
                return;
            };
            if (_arg_1 != null)
            {
                _width = _arg_1.width;
                _height = _arg_1.height;
            };
            _asset = _arg_1;
            _updateId++;
        }

        public function set assetName(_arg_1:String):void
        {
            if (_arg_1 == _assetName)
            {
                return;
            };
            _assetName = _arg_1;
            _updateId++;
        }

        public function set visible(_arg_1:Boolean):void
        {
            if (_arg_1 == _visible)
            {
                return;
            };
            _visible = _arg_1;
            _updateId++;
        }

        public function set tag(_arg_1:String):void
        {
            if (_arg_1 == _tag)
            {
                return;
            };
            _tag = _arg_1;
            _updateId++;
        }

        public function set alpha(_arg_1:int):void
        {
            _arg_1 = (_arg_1 & 0xFF);
            if (_arg_1 == _alpha)
            {
                return;
            };
            _alpha = _arg_1;
            _updateId++;
        }

        public function set color(_arg_1:int):void
        {
            _arg_1 = (_arg_1 & 0xFFFFFF);
            if (_arg_1 == _color)
            {
                return;
            };
            _color = _arg_1;
            _updateId++;
        }

        public function set blendMode(_arg_1:String):void
        {
            if (_arg_1 == _blendMode)
            {
                return;
            };
            _blendMode = _arg_1;
            _updateId++;
        }

        public function set filters(_arg_1:Array):void
        {
            if (_arg_1 == _filters)
            {
                return;
            };
            _filters = _arg_1;
            _updateId++;
        }

        public function set flipH(_arg_1:Boolean):void
        {
            if (_arg_1 == _flipH)
            {
                return;
            };
            _flipH = _arg_1;
            _updateId++;
        }

        public function set flipV(_arg_1:Boolean):void
        {
            if (_arg_1 == _flipV)
            {
                return;
            };
            _flipV = _arg_1;
            _updateId++;
        }

        public function set direction(_arg_1:int):void
        {
            _direction = _arg_1;
        }

        public function set offsetX(_arg_1:int):void
        {
            if (_arg_1 == _offset.x)
            {
                return;
            };
            _offset.x = _arg_1;
            _updateId++;
        }

        public function set offsetY(_arg_1:int):void
        {
            if (_arg_1 == _offset.y)
            {
                return;
            };
            _offset.y = _arg_1;
            _updateId++;
        }

        public function set relativeDepth(_arg_1:Number):void
        {
            if (_arg_1 == _relativeDepth)
            {
                return;
            };
            _relativeDepth = _arg_1;
            _updateId++;
        }

        public function set varyingDepth(_arg_1:Boolean):void
        {
            if (_arg_1 == _varyingDepth)
            {
                return;
            };
            _varyingDepth = _arg_1;
            _updateId++;
        }

        public function set clickHandling(_arg_1:Boolean):void
        {
            if (_clickHandling == _arg_1)
            {
                return;
            };
            _clickHandling = _arg_1;
            _updateId++;
        }

        public function get alphaTolerance():int
        {
            return (_alphaTolerance);
        }

        public function set alphaTolerance(_arg_1:int):void
        {
            if (_alphaTolerance == _arg_1)
            {
                return;
            };
            _alphaTolerance = _arg_1;
            _updateId++;
        }

        public function get libraryAssetName():String
        {
            return (_libraryAssetName);
        }

        public function set libraryAssetName(_arg_1:String):void
        {
            _libraryAssetName = _arg_1;
        }


    }
}

