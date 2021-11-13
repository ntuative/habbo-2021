package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.ShowEnforceRoomCategoryDialogParser;

        public class ShowEnforceRoomCategoryDialogEvent extends MessageEvent implements IMessageEvent 
    {

        public function ShowEnforceRoomCategoryDialogEvent(_arg_1:Function)
        {
            super(_arg_1, ShowEnforceRoomCategoryDialogParser);
        }

        public function getParser():ShowEnforceRoomCategoryDialogParser
        {
            return (this._SafeStr_816 as ShowEnforceRoomCategoryDialogParser);
        }


    }
}

