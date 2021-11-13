package com.sulake.habbo.ui.widget.furniture.friendfurni
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.handler.FriendFurniEngravingWidgetHandler;
    import com.sulake.habbo.room.object.data.StringArrayStuffData;

    public class FriendFurniEngravingWidget extends RoomWidgetBase 
    {

        private var _stuffId:int = -1;
        private var _SafeStr_4103:FriendFurniEngravingView;

        public function FriendFurniEngravingWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            engravingWidgetHandler.widget = this;
        }

        public function get stuffId():int
        {
            return (_stuffId);
        }

        public function get engravingWidgetHandler():FriendFurniEngravingWidgetHandler
        {
            return (_SafeStr_3915 as FriendFurniEngravingWidgetHandler);
        }

        public function open(_arg_1:int, _arg_2:int, _arg_3:StringArrayStuffData):void
        {
            close(_stuffId);
            _stuffId = _arg_1;
            switch (_arg_2)
            {
                case 0:
                    _SafeStr_4103 = new LoveLockEngravingView(this, _arg_3);
                    break;
                case 1:
                    break;
                case 2:
                    break;
                case 3:
                    _SafeStr_4103 = new WildWestEngravingView(this, _arg_3);
                    break;
                case 4:
                    _SafeStr_4103 = new HabboweenEngravingView(this, _arg_3);
                default:
            };
            _SafeStr_4103.open();
        }

        public function close(_arg_1:int):void
        {
            if (((_arg_1 == _stuffId) && (_SafeStr_4103)))
            {
                _SafeStr_4103.dispose();
                _SafeStr_4103 = null;
                _stuffId = -1;
            };
        }


    }
}

