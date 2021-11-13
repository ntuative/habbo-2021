package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuestRoomSearchResultMessageParser implements IMessageParser 
    {

        private var _data:GuestRoomSearchResultData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._data = new GuestRoomSearchResultData(_arg_1);
            return (true);
        }

        public function get data():GuestRoomSearchResultData
        {
            return (_data);
        }


    }
}