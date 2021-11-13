package com.sulake.habbo.nux
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class NuxOfferOldUserView 
    {

        private var _frame:IFrameWindow;
        private var _SafeStr_659:HabboNuxDialogs;

        public function NuxOfferOldUserView(_arg_1:HabboNuxDialogs)
        {
            _SafeStr_659 = _arg_1;
            show();
        }

        public function dispose():void
        {
            if (_frame)
            {
                _frame.dispose();
                _frame = null;
            };
            _SafeStr_659 = null;
        }

        private function hide():void
        {
            if (_SafeStr_659)
            {
                _SafeStr_659.destroyNuxOfferView();
            };
        }

        private function show():void
        {
            if (_frame != null)
            {
                return;
            };
            var _local_2:XmlAsset = (_SafeStr_659.assets.getAssetByName("nux_offer_old_user_xml") as XmlAsset);
            _frame = (_SafeStr_659.windowManager.buildFromXML((_local_2.content as XML)) as IFrameWindow);
            if (_frame == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            _frame.center();
            var _local_1:IWindow = _frame.findChildByTag("close");
            if (_local_1)
            {
                _local_1.visible = false;
            };
            _local_1 = _frame.findChildByName("btnSkip");
            _local_1.addEventListener("WME_CLICK", onReject);
            _local_1 = _frame.findChildByName("btnGo");
            _local_1.addEventListener("WME_CLICK", onVerify);
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            hide();
        }

        private function onVerify(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_659.onVerify();
            hide();
        }

        private function onReject(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_659.onReject();
        }


    }
}

