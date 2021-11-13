package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.quest.AcceptQuestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest.ActivateQuestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest._SafeStr_51;

    public class QuestDetails implements IDisposable 
    {

        private static const _SafeStr_3098:int = 56;
        private static const SPACING:int = 5;
        private static const TEXT_HEIGHT_SPACING:int = 5;
        private static const _SafeStr_3133:Point = new Point(8, 8);
        private static const _SafeStr_3134:Array = ["PLACE_ITEM", "PLACE_FLOOR", "PLACE_WALLPAPER", "PET_DRINK", "PET_EAT"];

        private var _questEngine:HabboQuestEngine;
        private var _window:IFrameWindow;
        private var _SafeStr_3135:Boolean;
        private var _SafeStr_3125:QuestMessageData;
        private var _msecsToRefresh:int;
        private var _SafeStr_3136:Boolean = false;

        public function QuestDetails(_arg_1:HabboQuestEngine)
        {
            _questEngine = _arg_1;
        }

        public function dispose():void
        {
            _questEngine = null;
            _SafeStr_3125 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_questEngine == null);
        }

        public function onQuest(_arg_1:QuestMessageData):void
        {
            if (_SafeStr_3135)
            {
                _SafeStr_3135 = false;
                openDetails(_arg_1);
            }
            else
            {
                if (((_SafeStr_3125 == null) || (!(_SafeStr_3125.id == _arg_1.id))))
                {
                    close();
                };
            };
        }

        public function onQuestCompleted(_arg_1:QuestMessageData):void
        {
            close();
        }

        public function onQuestCancelled():void
        {
            close();
        }

        public function onRoomExit():void
        {
            close();
        }

        private function close():void
        {
            if (_window)
            {
                _window.visible = false;
            };
        }

        public function showDetails(_arg_1:QuestMessageData):void
        {
            if (((_window) && (_window.visible)))
            {
                _window.visible = false;
                return;
            };
            openDetails(_arg_1);
        }

        public function openDetails(_arg_1:QuestMessageData, _arg_2:Boolean=false):void
        {
            var _local_5:IWindowContainer;
            _SafeStr_3125 = _arg_1;
            if (_arg_1 == null)
            {
                return;
            };
            _SafeStr_3136 = _arg_2;
            if (_window == null)
            {
                _window = IFrameWindow(_questEngine.getXmlWindow("QuestDetails"));
                _window.findChildByTag("close").procedure = onDetailsWindowClose;
                _window.center();
                _local_5 = _questEngine.questController.questsList.createListEntry(onAcceptQuest, onCancelQuest);
                _local_5.x = _SafeStr_3133.x;
                _local_5.y = _SafeStr_3133.y;
                _window.content.addChild(_local_5);
                _window.findChildByName("link_region").procedure = onLinkProc;
            };
            _local_5 = IWindowContainer(_window.findChildByName("entry_container"));
            _questEngine.questController.questsList.refreshEntryDetails(_local_5, _arg_1);
            var _local_8:Boolean = (_SafeStr_3125.waitPeriodSeconds > 0);
            var _local_3:ITextWindow = ITextWindow(_local_5.findChildByName("hint_txt"));
            var _local_9:int = getTextHeight(_local_3);
            if (!_local_8)
            {
                _local_3.caption = _questEngine.getQuestHint(_arg_1);
                _local_3.height = (_local_3.textHeight + 5);
            };
            _local_3.visible = (!(_local_8));
            var _local_4:int = (getTextHeight(_local_3) - _local_9);
            var _local_7:int = setupLink("link_region", ((_local_3.y + _local_3.height) + 5));
            var _local_6:IWindowContainer = IWindowContainer(_local_5.findChildByName("quest_container"));
            _local_6.height = (_local_6.height + (_local_4 + _local_7));
            _questEngine.questController.questsList.setEntryHeight(_local_5);
            _window.height = (_local_5.height + 56);
            _window.visible = true;
            _window.activate();
        }

        private function setupLink(_arg_1:String, _arg_2:int):int
        {
            var _local_3:Boolean = hasCatalogLink();
            var _local_8:Boolean = ((!(_local_3)) && (hasNavigatorLink()));
            var _local_5:Boolean = (((!(_local_3)) && (!(_local_8))) && (hasRoomLink()));
            var _local_6:Boolean = (((_local_3) || (_local_8)) || (_local_5));
            var _local_7:IRegionWindow = IRegionWindow(_window.findChildByName(_arg_1));
            _local_7.y = _arg_2;
            var _local_4:int;
            if (((_local_6) && (!(_local_7.visible))))
            {
                _local_4 = (5 + _local_7.height);
            };
            if (((!(_local_6)) && (_local_7.visible)))
            {
                _local_4 = (-(5) - _local_7.height);
            };
            _local_7.visible = _local_6;
            _local_7.findChildByName("link_catalog").visible = _local_3;
            _local_7.findChildByName("link_navigator").visible = _local_8;
            _local_7.findChildByName("link_room").visible = _local_5;
            return (_local_4);
        }

        private function hasCatalogLink():Boolean
        {
            return ((_SafeStr_3125.waitPeriodSeconds < 1) && (_SafeStr_3134.indexOf(_SafeStr_3125.type) > -1));
        }

        private function hasNavigatorLink():Boolean
        {
            var _local_2:Boolean = _questEngine.hasLocalizedValue((_SafeStr_3125.getCampaignLocalizationKey() + ".searchtag"));
            var _local_1:Boolean = _questEngine.hasLocalizedValue((_SafeStr_3125.getCampaignLocalizationKey() + ".searchtag"));
            return ((_SafeStr_3125.waitPeriodSeconds < 1) && ((_local_2) || (_local_1)));
        }

        private function hasRoomLink():Boolean
        {
            return (((_SafeStr_3125.waitPeriodSeconds < 1) && (_questEngine.isSeasonalQuest(_SafeStr_3125))) && (_questEngine.hasQuestRoomsIds()));
        }

        private function getTextHeight(_arg_1:ITextWindow):int
        {
            return ((_arg_1.visible) ? _arg_1.height : 0);
        }

        private function onDetailsWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _window.visible = false;
            };
        }

        public function set openForNextQuest(_arg_1:Boolean):void
        {
            _SafeStr_3135 = _arg_1;
        }

        private function onLinkProc(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                if (hasCatalogLink())
                {
                    _questEngine.openCatalog(_SafeStr_3125);
                }
                else
                {
                    if (hasNavigatorLink())
                    {
                        _questEngine.openNavigator(_SafeStr_3125);
                    }
                    else
                    {
                        _questEngine.goToQuestRooms();
                    };
                };
            };
        }

        public function update(_arg_1:uint):void
        {
            if (((_window == null) || (!(_window.visible))))
            {
                return;
            };
            _msecsToRefresh = (_msecsToRefresh - _arg_1);
            if (_msecsToRefresh > 0)
            {
                return;
            };
            _msecsToRefresh = 1000;
            var _local_2:Boolean = _questEngine.questController.questsList.refreshDelay(_window, _SafeStr_3125);
            if (_local_2)
            {
                openDetails(_SafeStr_3125, _SafeStr_3136);
            };
        }

        private function onAcceptQuest(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                if (_questEngine.currentlyInRoom)
                {
                    _questEngine.send(new AcceptQuestMessageComposer(_SafeStr_3125.id));
                }
                else
                {
                    _questEngine.send(new ActivateQuestMessageComposer(_SafeStr_3125.id));
                };
                _window.visible = false;
                _questEngine.questController.seasonalCalendarWindow.close();
                if (((_SafeStr_3136) && (_questEngine.isSeasonalQuest(_SafeStr_3125))))
                {
                    _questEngine.goToQuestRooms();
                };
            };
        }

        private function onCancelQuest(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _questEngine.send(new _SafeStr_51());
            };
        }


    }
}

