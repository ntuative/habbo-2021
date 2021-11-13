package com.sulake.habbo.communication.messages.parser.friendfurni
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class FriendFurniOtherLockConfirmedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FriendFurniOtherLockConfirmedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FriendFurniOtherLockConfirmedMessageParser);
        }

        public function getParser():FriendFurniOtherLockConfirmedMessageParser
        {
            return (_SafeStr_816 as FriendFurniOtherLockConfirmedMessageParser);
        }


    }
}

