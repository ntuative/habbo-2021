package com.sulake.habbo.communication.messages.parser.friendfurni
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class FriendFurniCancelLockMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FriendFurniCancelLockMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FriendFurniCancelLockMessageParser);
        }

        public function getParser():FriendFurniCancelLockMessageParser
        {
            return (_SafeStr_816 as FriendFurniCancelLockMessageParser);
        }


    }
}

