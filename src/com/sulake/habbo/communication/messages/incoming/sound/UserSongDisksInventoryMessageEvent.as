package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.UserSongDisksInventoryMessageParser;

        public class UserSongDisksInventoryMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserSongDisksInventoryMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserSongDisksInventoryMessageParser);
        }

        public function getParser():UserSongDisksInventoryMessageParser
        {
            return (this._SafeStr_816 as UserSongDisksInventoryMessageParser);
        }


    }
}

