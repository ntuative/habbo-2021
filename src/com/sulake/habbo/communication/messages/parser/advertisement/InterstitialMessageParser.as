package com.sulake.habbo.communication.messages.parser.advertisement
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class InterstitialMessageParser implements IMessageParser 
    {

        private var _canShowInterstitial:Boolean;


        public function get canShowInterstitial():Boolean
        {
            return (_canShowInterstitial);
        }

        public function flush():Boolean
        {
            _canShowInterstitial = false;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _canShowInterstitial = _arg_1.readBoolean();
            return (true);
        }


    }
}