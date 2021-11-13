package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ClubOfferExtendData extends ClubOfferData 
    {

        private var _SafeStr_1710:int;
        private var _SafeStr_1711:int;
        private var _originalActivityPointType:int;
        private var _subscriptionDaysLeft:int;

        public function ClubOfferExtendData(_arg_1:IMessageDataWrapper)
        {
            super(_arg_1);
            _SafeStr_1710 = _arg_1.readInteger();
            _SafeStr_1711 = _arg_1.readInteger();
            _originalActivityPointType = _arg_1.readInteger();
            _subscriptionDaysLeft = _arg_1.readInteger();
        }

        public function get originalPrice():int
        {
            return (_SafeStr_1710 * months);
        }

        public function get originalActivityPointPrice():int
        {
            return (_SafeStr_1711 * months);
        }

        public function get originalActivityPointType():int
        {
            return (_originalActivityPointType);
        }

        public function get discountCreditAmount():int
        {
            return ((_SafeStr_1710 * months) - this.priceCredits);
        }

        public function get discountActivityPointAmount():int
        {
            return ((originalActivityPointPrice * months) - this.priceActivityPoints);
        }

        public function get subscriptionDaysLeft():int
        {
            return (_subscriptionDaysLeft);
        }


    }
}

