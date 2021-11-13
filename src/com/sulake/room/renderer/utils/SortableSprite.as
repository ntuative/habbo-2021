package com.sulake.room.renderer.utils
{
    import com.sulake.room.object.visualization.ISortableSprite;
    import com.sulake.room.object.visualization.IRoomObjectSprite;

        public class SortableSprite implements ISortableSprite 
    {

        public static const _SafeStr_4483:Number = 100000000;

        private var _x:int = 0;
        private var _y:int = 0;
        private var _z:Number = 0;
        public var name:String = "";
        private var _sprite:IRoomObjectSprite = null;


        public function dispose():void
        {
            _sprite = null;
            _z = -(100000000);
        }

        public function get x():int
        {
            return (_x);
        }

        public function set x(_arg_1:int):void
        {
            _x = _arg_1;
        }

        public function get y():int
        {
            return (_y);
        }

        public function set y(_arg_1:int):void
        {
            _y = _arg_1;
        }

        public function get z():Number
        {
            return (_z);
        }

        public function set z(_arg_1:Number):void
        {
            _z = _arg_1;
        }

        public function get sprite():IRoomObjectSprite
        {
            return (_sprite);
        }

        public function set sprite(_arg_1:IRoomObjectSprite):void
        {
            _sprite = _arg_1;
        }


    }
}

