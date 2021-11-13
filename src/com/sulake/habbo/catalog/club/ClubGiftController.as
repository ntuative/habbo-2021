package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.communication.messages.outgoing.catalog._SafeStr_41;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.SelectClubGiftComposer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.purse.IPurse;

    public class ClubGiftController 
    {

        private var _SafeStr_1324:ClubGiftWidget;
        private var _daysUntilNextGift:int;
        private var _giftsAvailable:int;
        private var _offers:Array;
        private var _SafeStr_1435:Map;
        private var _catalog:HabboCatalog;
        private var _SafeStr_516:ClubGiftConfirmationDialog;

        public function ClubGiftController(_arg_1:HabboCatalog)
        {
            _catalog = _arg_1;
        }

        public function dispose():void
        {
            _catalog = null;
            if (_SafeStr_516)
            {
                _SafeStr_516.dispose();
                _SafeStr_516 = null;
            };
        }

        public function set widget(_arg_1:ClubGiftWidget):void
        {
            _SafeStr_1324 = _arg_1;
            _catalog.connection.send(new _SafeStr_41());
        }

        public function get daysUntilNextGift():int
        {
            return (_daysUntilNextGift);
        }

        public function get giftsAvailable():int
        {
            return (_giftsAvailable);
        }

        public function setInfo(_arg_1:int, _arg_2:int, _arg_3:Array, _arg_4:Map):void
        {
            _daysUntilNextGift = _arg_1;
            _giftsAvailable = _arg_2;
            _offers = _arg_3;
            _SafeStr_1435 = _arg_4;
            if (_SafeStr_1324)
            {
                _SafeStr_1324.update();
            };
        }

        public function selectGift(_arg_1:IPurchasableOffer):void
        {
            closeConfirmation();
            _SafeStr_516 = new ClubGiftConfirmationDialog(this, _arg_1);
        }

        public function confirmSelection(_arg_1:String):void
        {
            if ((((!(_arg_1)) || (!(_catalog))) || (!(_catalog.connection))))
            {
                return;
            };
            _catalog.connection.send(new SelectClubGiftComposer(_arg_1));
            _giftsAvailable--;
            _SafeStr_1324.update();
            closeConfirmation();
        }

        public function closeConfirmation():void
        {
            if (_SafeStr_516)
            {
                _SafeStr_516.dispose();
                _SafeStr_516 = null;
            };
        }

        public function getOffers():Array
        {
            return (_offers);
        }

        public function getGiftData():Map
        {
            return (_SafeStr_1435);
        }

        public function get hasClub():Boolean
        {
            if (((!(_catalog)) || (!(_catalog.getPurse()))))
            {
                return (false);
            };
            return (_catalog.getPurse().clubDays > 0);
        }

        public function get windowManager():IHabboWindowManager
        {
            if (!_catalog)
            {
                return (null);
            };
            return (_catalog.windowManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            if (!_catalog)
            {
                return (null);
            };
            return (_catalog.localization);
        }

        public function get assets():IAssetLibrary
        {
            if (!_catalog)
            {
                return (null);
            };
            return (_catalog.assets);
        }

        public function get roomEngine():IRoomEngine
        {
            if (!_catalog)
            {
                return (null);
            };
            return (_catalog.roomEngine);
        }

        public function getProductData(_arg_1:String):IProductData
        {
            if (!_catalog)
            {
                return (null);
            };
            return (_catalog.getProductData(_arg_1));
        }

        public function get purse():IPurse
        {
            if (!_catalog)
            {
                return (null);
            };
            return (_catalog.getPurse());
        }

        public function get catalog():HabboCatalog
        {
            return (_catalog);
        }


    }
}

