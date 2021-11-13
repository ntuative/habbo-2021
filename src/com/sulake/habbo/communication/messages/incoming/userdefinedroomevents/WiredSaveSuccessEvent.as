package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents._SafeStr_69;

        public class WiredSaveSuccessEvent extends MessageEvent implements IMessageEvent 
    {

        public function WiredSaveSuccessEvent(_arg_1:Function)
        {
            super(_arg_1, _SafeStr_69);
        }

        public function getParser():_SafeStr_69
        {
            return (this._SafeStr_816 as _SafeStr_69);
        }


    }
}

