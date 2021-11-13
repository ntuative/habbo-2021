package com.sulake.habbo.ui.widget.furniture.highscore
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBubbleWindow;
    import flash.geom.Point;
    import com.sulake.habbo.ui.handler.HighScoreFurniWidgetHandler;
    import flash.geom.Rectangle;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.room.object.data.HighScoreData;
    import com.sulake.habbo.room.object.data.HighScoreStuffData;

    public class HighScoreDisplayWidget extends RoomWidgetBase 
    {

        public static const INVALID_ID:int = -1;
        private static const RELATIVE_OFFSET_X:int = -138;
        private static const RELATIVE_OFFSET_Y:int = -400;
        private static const SCORETYPE_ONE_PER_TEAM:int = 0;
        private static const SCORETYPE_AGGREGATED_WINS:int = 1;
        private static const SCORETYPE_ALWAYS_NEW_SCORE:int = 2;
        private static const CLEARTYPE_NEVER:int = 0;
        private static const CLEARTYPE_DAILY:int = 1;
        private static const CLEARTYPE_WEEKLY:int = 2;
        private static const CLEARTYPE_MONTHLY:int = 3;
        private static const SCORETYPE_LOCALIZATION_KEY_POSTFIX:Array = ["perteam", "mostwins", "classic"];
        private static const CLEARTYPE_LOCALIZATION_KEY_POSTFIX:Array = ["alltime", "daily", "weekly", "monthly"];

        private var _mainWindow:IWindowContainer;
        private var _bubble:IBubbleWindow;
        private var _SafeStr_4105:IWindowContainer;
        private var _roomId:int = -1;
        private var _roomObjId:int = -1;
        private var _lastPosition:Point = new Point(0, 0);

        public function HighScoreDisplayWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            HighScoreFurniWidgetHandler(_arg_1).widget = this;
            _mainWindow = IWindowContainer(_arg_2.createWindow("room_widget_highscore_background_container", "", 4, 0, 0, new Rectangle(0, 0, 10, 10)));
            resizeRootContainerToDesktop();
            _mainWindow.addEventListener("WE_PARENT_RESIZED", resizeRootContainerToDesktop);
        }

        private function resizeRootContainerToDesktop(_arg_1:WindowEvent=null):void
        {
            _mainWindow.width = _mainWindow.desktop.width;
            _mainWindow.height = _mainWindow.desktop.height;
        }

        override public function get mainWindow():IWindow
        {
            return (_mainWindow);
        }

        override public function dispose():void
        {
            if (_bubble != null)
            {
                destroyWindow();
            };
            _mainWindow.removeEventListener("WE_PARENT_RESIZED", resizeRootContainerToDesktop);
            _mainWindow.dispose();
            super.dispose();
        }

        public function open(_arg_1:int, _arg_2:int, _arg_3:HighScoreStuffData):void
        {
            var _local_4:String;
            var _local_8:String;
            var _local_6:IWindowContainer;
            if (_bubble != null)
            {
                destroyWindow();
            };
            if (((!(_arg_3.clearType == -1)) && (!(_arg_3.scoreType == -1))))
            {
                _local_4 = HighScoreFurniWidgetHandler(_SafeStr_3915).container.localization.getLocalization(("high.score.display.cleartype." + CLEARTYPE_LOCALIZATION_KEY_POSTFIX[_arg_3.clearType]));
                _local_8 = HighScoreFurniWidgetHandler(_SafeStr_3915).container.localization.getLocalization(("high.score.display.scoretype." + SCORETYPE_LOCALIZATION_KEY_POSTFIX[_arg_3.scoreType]));
                HighScoreFurniWidgetHandler(_SafeStr_3915).container.localization.registerParameter("high.score.display.caption", "cleartype", _local_4);
                HighScoreFurniWidgetHandler(_SafeStr_3915).container.localization.registerParameter("high.score.display.caption", "scoretype", _local_8);
            };
            _roomId = _arg_2;
            _roomObjId = _arg_1;
            createWindow();
            if (!_SafeStr_4105)
            {
                Logger.log("ERROR: 'entry_template' could not found from high score display's window XML");
                return;
            };
            var _local_7:IItemListWindow = IItemListWindow(_bubble.findChildByName("entries"));
            for each (var _local_5:HighScoreData in _arg_3.entries)
            {
                _local_6 = IWindowContainer(_SafeStr_4105.clone());
                _local_6.getChildByName("usernames").caption = getUserNameList(_local_5.users);
                _local_6.getChildByName("score").caption = _local_5.score.toString();
                _local_7.addListItem(_local_6);
            };
            _local_7.invalidate();
        }

        private function getUserNameList(_arg_1:Array):String
        {
            var _local_2:String = "";
            for each (var _local_3:String in _arg_1)
            {
                _local_2 = ((_local_2 + _local_3) + ", ");
            };
            return (_local_2.substr(0, (_local_2.length - 2)));
        }

        public function setRelativePositionToRoomObjectAt(_arg_1:int, _arg_2:int):void
        {
            if (!_bubble)
            {
                return;
            };
            _bubble.x = (_arg_1 + -138);
            _bubble.y = (_arg_2 + -400);
        }

        private function createWindow():void
        {
            var _local_1:IBubbleWindow = IBubbleWindow(windowManager.buildFromXML(XML(assets.getAssetByName("high_score_display_xml").content)));
            _SafeStr_4105 = IWindowContainer(_local_1.findChildByName("entry_template"));
            IItemListWindow(_local_1.findChildByName("entries")).removeListItem(_SafeStr_4105);
            _bubble = _local_1;
            _bubble.x = _lastPosition.x;
            _bubble.y = _lastPosition.y;
            _mainWindow.addChild(_local_1);
        }

        private function destroyWindow():void
        {
            _mainWindow.removeChild(_bubble);
            _lastPosition.x = _bubble.x;
            _lastPosition.y = _bubble.y;
            _bubble.dispose();
            _bubble = null;
            _roomId = -1;
            _roomObjId = -1;
        }

        public function get isOpen():Boolean
        {
            return ((!(_bubble == null)) && (_bubble.visible));
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get roomObjId():int
        {
            return (_roomObjId);
        }

        public function close():void
        {
            destroyWindow();
        }


    }
}

