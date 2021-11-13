package com.sulake.habbo.ui.widget.furniture.clothingchange
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetClothingChangeUpdateEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetClothingChangeMessage;

    public class ClothingChangeFurnitureWidget extends RoomWidgetBase 
    {

        private static const _SafeStr_4062:String = "Boy";
        private static const _SafeStr_4063:String = "Girl";

        private var _SafeStr_4064:IWindowContainer;
        private var _SafeStr_1922:int = 0;
        private var _SafeStr_1924:int = 0;
        private var _SafeStr_1907:int = 0;

        public function ClothingChangeFurnitureWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        override public function dispose():void
        {
            hideGenderSelectionInterface();
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWCCUE_SHOW_GENDER_SELECTION", onUpdate);
            _arg_1.addEventListener("RWCCUE_SHOW_CLOTHING_EDITOR", onUpdate);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWCCUE_SHOW_GENDER_SELECTION", onUpdate);
            _arg_1.removeEventListener("RWCCUE_SHOW_CLOTHING_EDITOR", onUpdate);
        }

        private function onUpdate(_arg_1:RoomWidgetClothingChangeUpdateEvent):void
        {
            switch (_arg_1.type)
            {
                case "RWCCUE_SHOW_GENDER_SELECTION":
                    showGenderSelectionInterface(_arg_1);
                    return;
            };
        }

        private function showGenderSelectionInterface(_arg_1:RoomWidgetClothingChangeUpdateEvent):void
        {
            hideGenderSelectionInterface();
            _SafeStr_1922 = _arg_1.objectId;
            _SafeStr_1924 = _arg_1.objectCategory;
            _SafeStr_1907 = _arg_1.roomId;
            var _local_4:IAsset = assets.getAssetByName("boygirl");
            var _local_2:XmlAsset = XmlAsset(_local_4);
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_4064 = (windowManager.createWindow("clothing change gender selection", "", 4, 0, (((0x8000 | 0x01) | 0x020000) | 0x01), new Rectangle(100, 100, 200, 200), null, 0) as IWindowContainer);
            _SafeStr_4064.buildFromXML(XML(_local_2.content));
            _SafeStr_4064.addEventListener("WME_CLICK", onGenderSelectionMouseEvent);
            _SafeStr_4064.center();
            var _local_3:IWindow = _SafeStr_4064.findChildByTag("close");
            if (_local_3 != null)
            {
                _local_3.procedure = onGenderSelectionWindowClose;
            };
            _local_3 = _SafeStr_4064.findChildByName("Boy");
            if (_local_3 != null)
            {
                _local_3.addEventListener("WME_CLICK", onGenderSelectionMouseEvent);
            };
            _local_3 = _SafeStr_4064.findChildByName("Girl");
            if (_local_3 != null)
            {
                _local_3.addEventListener("WME_CLICK", onGenderSelectionMouseEvent);
            };
        }

        private function hideGenderSelectionInterface():void
        {
            if (_SafeStr_4064 != null)
            {
                _SafeStr_4064.dispose();
                _SafeStr_4064 = null;
            };
        }

        private function onGenderSelectionWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            hideGenderSelectionInterface();
        }

        private function onGenderSelectionMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3)
            {
                case "Boy":
                    requestEditor("M");
                    hideGenderSelectionInterface();
                    return;
                case "Girl":
                    requestEditor("F");
                    hideGenderSelectionInterface();
                    return;
                case "close":
                case "close_btn":
                    hideGenderSelectionInterface();
                    return;
            };
        }

        private function requestEditor(_arg_1:String):void
        {
            var _local_2:RoomWidgetClothingChangeMessage = new RoomWidgetClothingChangeMessage("RWCCM_REQUEST_EDITOR", _arg_1, _SafeStr_1922, _SafeStr_1924, _SafeStr_1907);
            messageListener.processWidgetMessage(_local_2);
        }


    }
}

