package com.sulake.habbo.nux
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class NuxNoobRoomOfferView 
    {

        private var _frame:IFrameWindow;
        private var _SafeStr_659:HabboNuxDialogs;

        public function NuxNoobRoomOfferView(_arg_1:HabboNuxDialogs)
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
            var _local_3:XmlAsset = (_SafeStr_659.assets.getAssetByName("nux_noob_room_offer_xml") as XmlAsset);
            _frame = (_SafeStr_659.windowManager.buildFromXML((_local_3.content as XML)) as IFrameWindow);
            if (_frame == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            var _local_4:Number = 20;
            _frame.y = _local_4;
            _frame.x = _local_4;
            var _local_1:IWindow = _frame.findChildByName("btnGo");
            if (_local_1)
            {
                _local_1.addEventListener("WME_CLICK", onGo);
            };
            var _local_2:IWindow = _frame.findChildByTag("close");
            if (_local_2)
            {
                _local_2.addEventListener("WME_CLICK", onClose);
            };
        }

        private function onGo(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_659.context.createLinkEvent("navigator/goto/predefined_noob_lobby");
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_659.destroyNoobRoomOfferView();
        }


    }
}

