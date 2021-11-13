package com.sulake.room.renderer.utils
{
    import flash.display.Bitmap;
    import flash.geom.Point;
    import flash.display.BitmapData;

       public class ExtendedSprite extends Bitmap
    {

        private var _alphaTolerance:int = 128;
        private var _basePoint:Point;
        private var _tag:String = "";
        private var _identifier:String = "";
        private var _clickHandling:Boolean = false;
        private var _varyingDepth:Boolean = false;
        private var _bitmapData:ExtendedBitmapData = null;
        private var _width:int = 0;
        private var _SafeStr_1113:int = 0;
        private var _updateID1:int = -1;
        private var _updateID2:int = -1;
        private var _offsetRefX:int = 0;
        private var _offsetRefY:int = 0;

        public function ExtendedSprite():void
        {
            _basePoint = new Point();
            cacheAsBitmap = false;
        }

        public function get alphaTolerance():int
        {
            return (_alphaTolerance);
        }

        public function set alphaTolerance(_arg_1:int):void
        {
            _alphaTolerance = _arg_1;
        }

        public function get tag():String
        {
            return (_tag);
        }

        public function set tag(_arg_1:String):void
        {
            _tag = _arg_1;
        }

        public function get identifier():String
        {
            return (_identifier);
        }

        public function set identifier(_arg_1:String):void
        {
            _identifier = _arg_1;
        }

        public function get varyingDepth():Boolean
        {
            return (_varyingDepth);
        }

        public function set varyingDepth(_arg_1:Boolean):void
        {
            _varyingDepth = _arg_1;
        }

        public function get clickHandling():Boolean
        {
            return (_clickHandling);
        }

        public function set clickHandling(_arg_1:Boolean):void
        {
            _clickHandling = _arg_1;
        }

        public function get offsetRefX():int
        {
            return (_offsetRefX);
        }

        public function set offsetRefX(_arg_1:int):void
        {
            _offsetRefX = _arg_1;
        }

        public function get offsetRefY():int
        {
            return (_offsetRefY);
        }

        public function set offsetRefY(_arg_1:int):void
        {
            _offsetRefY = _arg_1;
        }

        public function dispose():void
        {
            if (_bitmapData != null)
            {
                _bitmapData.dispose();
                _bitmapData = null;
            };
        }

        override public function set bitmapData(_arg_1:BitmapData):void
        {
            var _local_2:ExtendedBitmapData;
            if (_arg_1 == bitmapData)
            {
                return;
            };
            if (_bitmapData != null)
            {
                _bitmapData.dispose();
                _bitmapData = null;
            };
            if (_arg_1 != null)
            {
                _width = _arg_1.width;
                _SafeStr_1113 = _arg_1.height;
                _local_2 = (_arg_1 as ExtendedBitmapData);
                if (_local_2 != null)
                {
                    _local_2.addReference();
                    _bitmapData = _local_2;
                };
            }
            else
            {
                _width = 0;
                _SafeStr_1113 = 0;
                _updateID1 = -1;
                _updateID2 = -1;
            };
            super.bitmapData = _arg_1;
        }

        public function needsUpdate(_arg_1:int, _arg_2:int):Boolean
        {
            if (((!(_arg_1 == _updateID1)) || (!(_arg_2 == _updateID2))))
            {
                _updateID1 = _arg_1;
                _updateID2 = _arg_2;
                return (true);
            };
            if (((!(_bitmapData == null)) && (_bitmapData.disposed)))
            {
                return (true);
            };
            return (false);
        }

        override public function hitTestPoint(_arg_1:Number, _arg_2:Number, _arg_3:Boolean=false):Boolean
        {
            return (hitTest(_arg_1, _arg_2));
        }

        public function hitTest(_arg_1:int, _arg_2:int):Boolean
        {
            if (((_alphaTolerance > 0xFF) || (bitmapData == null)))
            {
                return (false);
            };
            if (((((_arg_1 < 0) || (_arg_2 < 0)) || (_arg_1 >= _width)) || (_arg_2 >= _SafeStr_1113)))
            {
                return (false);
            };
            return (hitTestBitmapData(_arg_1, _arg_2));
        }

        private function hitTestBitmapData(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_4:uint;
            var _local_3:Boolean;
            try
            {
                _local_4 = bitmapData.getPixel32(_arg_1, _arg_2);
                _local_4 = (_local_4 >> 24);
                _local_3 = (_local_4 > _alphaTolerance);
            }
            catch(e:Error)
            {
            };
            return (_local_3);
        }


    }
}