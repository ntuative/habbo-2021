package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.EventCategory;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UserEventCatsMessageParser implements IMessageParser 
    {

        private var _eventCategories:Array;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            _eventCategories = [];
            var _local_3:int = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _eventCategories.push(new EventCategory(_arg_1));
                _local_2++;
            };
            return (true);
        }

        public function flush():Boolean
        {
            _eventCategories = null;
            return (true);
        }

        public function get eventCategories():Array
        {
            return (_eventCategories);
        }


    }
}