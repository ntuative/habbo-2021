package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferExtendData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HabboClubExtendOfferMessageParser implements IMessageParser 
    {

        private var _offer:ClubOfferExtendData;


        public function flush():Boolean
        {
            _offer = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _offer = new ClubOfferExtendData(_arg_1);
            return (true);
        }

        public function offer():ClubOfferExtendData
        {
            return (_offer);
        }


    }
}