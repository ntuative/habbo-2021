package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FlatControllerData implements IFlatUser 
    {

        private var _userId:int;
        private var _userName:String;
        private var _selected:Boolean;

        public function FlatControllerData(_arg_1:IMessageDataWrapper)
        {
            this._userId = _arg_1.readInteger();
            this._userName = _arg_1.readString();
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get selected():Boolean
        {
            return (_selected);
        }

        public function set selected(_arg_1:Boolean):void
        {
            _selected = _arg_1;
        }


    }
}