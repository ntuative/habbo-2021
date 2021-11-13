package com.sulake.habbo.communication.messages.incoming.newnavigator
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class LiftedRoomData 
    {

        private var _flatId:int;
        private var _areaId:int;
        private var _image:String;
        private var _caption:String;

        public function LiftedRoomData(_arg_1:IMessageDataWrapper)
        {
            _flatId = _arg_1.readInteger();
            _areaId = _arg_1.readInteger();
            _image = _arg_1.readString();
            _caption = _arg_1.readString();
        }

        public function get flatId():int
        {
            return (_flatId);
        }

        public function get areaId():int
        {
            return (_areaId);
        }

        public function get image():String
        {
            return (_image);
        }

        public function get caption():String
        {
            return (_caption);
        }


    }
}