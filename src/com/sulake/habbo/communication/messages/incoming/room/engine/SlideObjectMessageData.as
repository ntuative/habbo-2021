package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.room.utils.Vector3d;

        public class SlideObjectMessageData 
    {

        public static const _SafeStr_1819:String = "mv";
        public static const _SafeStr_1820:String = "sld";

        private var _id:int = 0;
        private var _loc:Vector3d;
        private var _target:Vector3d;
        private var _moveType:String;
        private var _SafeStr_1818:Boolean = false;

        public function SlideObjectMessageData(_arg_1:int, _arg_2:Vector3d, _arg_3:Vector3d, _arg_4:String=null)
        {
            _id = _arg_1;
            _loc = _arg_2;
            _target = _arg_3;
            _moveType = _arg_4;
        }

        public function setReadOnly():void
        {
            _SafeStr_1818 = true;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get loc():Vector3d
        {
            return (_loc);
        }

        public function set loc(_arg_1:Vector3d):void
        {
            if (!_SafeStr_1818)
            {
                _loc = _arg_1;
            };
        }

        public function get target():Vector3d
        {
            return (_target);
        }

        public function set target(_arg_1:Vector3d):void
        {
            if (!_SafeStr_1818)
            {
                _target = _arg_1;
            };
        }

        public function get moveType():String
        {
            return (_moveType);
        }

        public function set moveType(_arg_1:String):void
        {
            if (!_SafeStr_1818)
            {
                _moveType = _arg_1;
            };
        }


    }
}

