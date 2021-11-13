package com.sulake.habbo.session.handler
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectsMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectsMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class AvatarEffectsHandler extends BaseHandler 
    {

        public function AvatarEffectsHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null)
            {
                return;
            };
        }

        private function onAvatarEffects(_arg_1:IMessageEvent):void
        {
            var _local_3:AvatarEffectsMessageEvent = (_arg_1 as AvatarEffectsMessageEvent);
            var _local_2:AvatarEffectsMessageParser = (_local_3.getParser() as AvatarEffectsMessageParser);
            Logger.log(("Received active avatar effects: " + _local_2.effects));
            if (((listener) && (listener.events)))
            {
            };
        }


    }
}

