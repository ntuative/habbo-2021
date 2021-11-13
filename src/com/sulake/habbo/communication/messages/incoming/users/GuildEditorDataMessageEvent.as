package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.GuildEditorDataMessageParser;

        public class GuildEditorDataMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuildEditorDataMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuildEditorDataMessageParser);
        }

        public function get data():GuildEditorData
        {
            return (GuildEditorDataMessageParser(_SafeStr_816).data);
        }


    }
}

