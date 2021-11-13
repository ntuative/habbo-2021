package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.window.utils.ChildEntityArray;
    import flash.geom.Rectangle;
    import com.sulake.core.window.utils.IChildEntity;

    public class SkinLayout extends ChildEntityArray implements ISkinLayout 
    {

        protected var _name:String;
        protected var _width:uint;
        protected var _SafeStr_1113:uint;
        protected var _SafeStr_1114:String;
        protected var _SafeStr_1115:Boolean;

        public function SkinLayout(_arg_1:String, _arg_2:Boolean, _arg_3:String)
        {
            _name = _arg_1;
            _width = 0;
            _SafeStr_1113 = 0;
            _SafeStr_1114 = _arg_3;
            _SafeStr_1115 = _arg_2;
        }

        public function get name():String
        {
            return (_name);
        }

        public function get width():uint
        {
            return (_width);
        }

        public function get height():uint
        {
            return (_SafeStr_1113);
        }

        public function get blendMode():String
        {
            return (_SafeStr_1114);
        }

        public function get transparent():Boolean
        {
            return (_SafeStr_1115);
        }

        public function dispose():void
        {
            var _local_2:uint;
            var _local_1:uint = numChildren;
            _local_2 = 0;
            while (_local_2 < _local_1)
            {
                SkinLayoutEntity(removeChildAt(0)).dispose();
                _local_2++;
            };
        }

        public function calculateActualRect(_arg_1:Rectangle):void
        {
            var _local_5:SkinLayoutEntity;
            var _local_3:uint;
            var _local_4:Rectangle;
            var _local_2:uint = numChildren;
            _arg_1.x = 0xFFFFFFFF;
            _arg_1.y = 0xFFFFFFFF;
            _arg_1.width = 0;
            _arg_1.height = 0;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_5 = (getChildAt(_local_3) as SkinLayoutEntity);
                _local_4 = _local_5.region;
                if (_local_4.left < _arg_1.left)
                {
                    _arg_1.left = _local_4.left;
                };
                if (_local_4.top < _arg_1.top)
                {
                    _arg_1.top = _local_4.top;
                };
                if (_local_4.right > _arg_1.right)
                {
                    _arg_1.right = _local_4.right;
                };
                if (_local_4.bottom > _arg_1.bottom)
                {
                    _arg_1.bottom = _local_4.bottom;
                };
                _local_3++;
            };
        }

        public function isFixedWidth():Boolean
        {
            var _local_2:uint;
            var _local_1:uint = numChildren;
            if (_local_1 == 0)
            {
                return (false);
            };
            _local_2 = 0;
            while (_local_2 < _local_1)
            {
                if (SkinLayoutEntity(getChildAt(_local_2)).scaleH != 0)
                {
                    return (false);
                };
                _local_2++;
            };
            return (true);
        }

        public function calculateWidth():uint
        {
            var _local_4:Rectangle;
            var _local_3:uint;
            var _local_2:uint;
            var _local_1:uint = numChildren;
            _local_3 = 0;
            while (_local_3 < _local_1)
            {
                _local_4 = SkinLayoutEntity(getChildAt(_local_3)).region;
                if (_local_4.right > _local_2)
                {
                    _local_2 = _local_4.right;
                };
                _local_3++;
            };
            return (_local_2);
        }

        public function isFixedHeight():Boolean
        {
            var _local_2:uint;
            var _local_1:uint = numChildren;
            if (_local_1 == 0)
            {
                return (false);
            };
            _local_2 = 0;
            while (_local_2 < _local_1)
            {
                if (SkinLayoutEntity(getChildAt(_local_2)).scaleV != 0)
                {
                    return (false);
                };
                _local_2++;
            };
            return (true);
        }

        public function calculateHeight():uint
        {
            var _local_3:Rectangle;
            var _local_2:uint;
            var _local_4:uint;
            var _local_1:uint = numChildren;
            _local_2 = 0;
            while (_local_2 < _local_1)
            {
                _local_3 = SkinLayoutEntity(getChildAt(_local_2)).region;
                if (_local_3.bottom > _local_4)
                {
                    _local_4 = _local_3.bottom;
                };
                _local_2++;
            };
            return (_local_4);
        }

        public function getDefaultRegion(_arg_1:String, _arg_2:Rectangle):void
        {
            var _local_3:SkinLayoutEntity = (getChildByName(_arg_1) as SkinLayoutEntity);
            if (_local_3 == null)
            {
                throw (new Error((("Entity not found: " + _arg_1) + "!")));
            };
            _arg_2.x = _local_3.region.x;
            _arg_2.y = _local_3.region.y;
            _arg_2.width = _local_3.region.width;
            _arg_2.height = _local_3.region.height;
        }

        override public function addChild(_arg_1:IChildEntity):IChildEntity
        {
            var _local_2:SkinLayoutEntity = SkinLayoutEntity(_arg_1);
            _width = ((_local_2.region.right > _width) ? _local_2.region.right : _width);
            _SafeStr_1113 = ((_local_2.region.bottom > _SafeStr_1113) ? _local_2.region.bottom : _SafeStr_1113);
            return (super.addChild(_arg_1));
        }

        override public function addChildAt(_arg_1:IChildEntity, _arg_2:int):IChildEntity
        {
            var _local_3:SkinLayoutEntity = SkinLayoutEntity(_arg_1);
            _width = ((_local_3.region.right > _width) ? _local_3.region.right : _width);
            _SafeStr_1113 = ((_local_3.region.bottom > _SafeStr_1113) ? _local_3.region.bottom : _SafeStr_1113);
            return (super.addChildAt(_arg_1, _arg_2));
        }

        override public function removeChild(_arg_1:IChildEntity):IChildEntity
        {
            super.removeChild(_arg_1);
            _width = calculateWidth();
            _SafeStr_1113 = calculateHeight();
            return (_arg_1);
        }

        override public function removeChildAt(_arg_1:int):IChildEntity
        {
            var _local_2:IChildEntity = super.removeChildAt(_arg_1);
            _width = calculateWidth();
            _SafeStr_1113 = calculateHeight();
            return (_local_2);
        }


    }
}

