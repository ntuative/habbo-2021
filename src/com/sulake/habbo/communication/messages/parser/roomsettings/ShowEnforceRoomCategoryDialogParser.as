package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ShowEnforceRoomCategoryDialogParser implements IMessageParser 
    {

        private var _selectionType:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _selectionType = _arg_1.readInteger();
            return (true);
        }

        public function get selectionType():int
        {
            return (_selectionType);
        }


    }
}