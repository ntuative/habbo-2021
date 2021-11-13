package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.ui.handler.InfoStandWidgetHandler;
    import com.sulake.core.window.IWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.utils.Map;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetFigureUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetCommandsUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;

    public class InfoStandWidget extends RoomWidgetBase 
    {

        private const USER_VIEW:String = "infostand_user_view";
        private const _SafeStr_4160:String = "infostand_furni_view";
        private const PET_VIEW:String = "infostand_pet_view";
        private const BOT_VIEW:String = "infostand_bot_view";
        private const RENTABLE_BOT_VIEW:String = "infostand_rentable_bot_view";
        private const _SafeStr_4161:String = "infostand_jukebox_view";
        private const CRACKABLE_FURNI_VIEW:String = "infostand_crackable_furni_view";
        private const SONGDISK_VIEW:String = "infostand_songdisk_view";
        private const UPDATE_INTERVAL_MS:int = 3000;

        private var _furniView:InfoStandFurniView;
        private var _SafeStr_4162:InfoStandUserView;
        private var _SafeStr_4163:InfoStandPetView;
        private var _SafeStr_4164:InfoStandBotView;
        private var _SafeStr_4165:InfoStandRentableBotView;
        private var _SafeStr_4166:InfoStandJukeboxView;
        private var _SafeStr_4167:InfoStandCrackableFurniView;
        private var _SafeStr_4168:InfoStandSongDiskView;
        private var _SafeStr_4169:Array;
        private var _userData:InfoStandUserData;
        private var _furniData:InfoStandFurniData;
        private var _petData:InfoStandPetData;
        private var _rentableBotData:InfoStandRentableBotData;
        private var _SafeStr_4170:IWindowContainer;
        private var _SafeStr_1507:Timer;
        private var _config:ICoreConfiguration;

        public function InfoStandWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:ICoreConfiguration, _arg_6:IHabboCatalog)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _config = _arg_5;
            _furniView = new InfoStandFurniView(this, "infostand_furni_view", _arg_6);
            _SafeStr_4162 = new InfoStandUserView(this, "infostand_user_view");
            _SafeStr_4163 = new InfoStandPetView(this, "infostand_pet_view", _arg_6);
            _SafeStr_4164 = new InfoStandBotView(this, "infostand_bot_view");
            _SafeStr_4165 = new InfoStandRentableBotView(this, "infostand_rentable_bot_view", _arg_6);
            _SafeStr_4166 = new InfoStandJukeboxView(this, "infostand_jukebox_view", _arg_6);
            _SafeStr_4167 = new InfoStandCrackableFurniView(this, "infostand_crackable_furni_view", _arg_6);
            _SafeStr_4168 = new InfoStandSongDiskView(this, "infostand_songdisk_view", _arg_6);
            _userData = new InfoStandUserData();
            _furniData = new InfoStandFurniData();
            _petData = new InfoStandPetData();
            _rentableBotData = new InfoStandRentableBotData();
            _SafeStr_1507 = new Timer(3000);
            _SafeStr_1507.addEventListener("timer", onUpdateTimer);
            mainContainer.visible = false;
            this.handler.widget = this;
        }

        public function get handler():InfoStandWidgetHandler
        {
            return (_SafeStr_3915 as InfoStandWidgetHandler);
        }

        public function get furniView():InfoStandFurniView
        {
            return (_furniView);
        }

        override public function get mainWindow():IWindow
        {
            return (mainContainer);
        }

        public function get config():ICoreConfiguration
        {
            return (_config);
        }

        public function get mainContainer():IWindowContainer
        {
            if (_SafeStr_4170 == null)
            {
                _SafeStr_4170 = (windowManager.createWindow("infostand_main_container", "", 4, 0, 0, new Rectangle(0, 0, 50, 100)) as IWindowContainer);
                _SafeStr_4170.tags.push("room_widget_infostand");
                _SafeStr_4170.background = true;
                _SafeStr_4170.color = 0;
            };
            return (_SafeStr_4170);
        }

        public function favouriteGroupUpdated(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):void
        {
            var _local_6:String;
            if (((!(userData)) || (!(userData.userRoomId == _arg_1))))
            {
                return;
            };
            if (!mainContainer)
            {
                return;
            };
            var _local_5:IWindow = mainContainer.findChildByName("infostand_user_view");
            if (((!(_local_5)) || (!(_local_5.visible))))
            {
                return;
            };
            _SafeStr_4162.clearGroupBadge();
            if (_arg_2 != -1)
            {
                _local_6 = handler.container.sessionDataManager.getGroupBadgeId(_arg_2);
                userData.groupId = _arg_2;
                userData.groupBadgeId = _local_6;
                userData.groupName = _arg_4;
                _SafeStr_4162.setGroupBadge(_local_6);
            };
        }

        public function getXmlWindow(_arg_1:String):IWindow
        {
            var _local_4:IAsset;
            var _local_2:XmlAsset;
            var _local_3:IWindow;
            try
            {
                _local_4 = assets.getAssetByName(_arg_1);
                _local_2 = XmlAsset(_local_4);
                _local_3 = windowManager.buildFromXML(XML(_local_2.content));
            }
            catch(e:Error)
            {
                Logger.log(("[InfoStandWidget] Missing window XML: " + _arg_1));
            };
            return (_local_3);
        }

        public function setRelationshipStatus(_arg_1:int, _arg_2:Map):void
        {
            if (_userData.userId == _arg_1)
            {
                _SafeStr_4162.setRelationshipStatuses(_arg_2);
            };
        }

        override public function dispose():void
        {
            if (_SafeStr_1507)
            {
                _SafeStr_1507.stop();
            };
            _SafeStr_1507 = null;
            if (_SafeStr_4162)
            {
                _SafeStr_4162.dispose();
            };
            _SafeStr_4162 = null;
            if (_furniView)
            {
                _furniView.dispose();
            };
            _furniView = null;
            if (_SafeStr_4164)
            {
                _SafeStr_4164.dispose();
            };
            _SafeStr_4164 = null;
            if (_SafeStr_4165)
            {
                _SafeStr_4165.dispose();
            };
            _SafeStr_4165 = null;
            if (_SafeStr_4163)
            {
                _SafeStr_4163.dispose();
            };
            _SafeStr_4163 = null;
            if (_SafeStr_4166)
            {
                _SafeStr_4166.dispose();
            };
            _SafeStr_4166 = null;
            if (_SafeStr_4167)
            {
                _SafeStr_4167.dispose();
            };
            _SafeStr_4167 = null;
            if (_SafeStr_4168)
            {
                _SafeStr_4168.dispose();
            };
            _SafeStr_4168 = null;
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWROUE_OBJECT_SELECTED", onRoomObjectSelected);
            _arg_1.addEventListener("RWROUE_OBJECT_DESELECTED", onClose);
            _arg_1.addEventListener("RWROUE_USER_REMOVED", onRoomObjectRemoved);
            _arg_1.addEventListener("RWROUE_FURNI_REMOVED", onRoomObjectRemoved);
            _arg_1.addEventListener("RWUIUE_OWN_USER", onUserInfo);
            _arg_1.addEventListener("RWUIUE_PEER", onUserInfo);
            _arg_1.addEventListener("RWUIUE_BOT", onBotInfo);
            _arg_1.addEventListener("RWFIUE_FURNI", onFurniInfo);
            _arg_1.addEventListener("RWRBIUE_RENTABLE_BOT", onRentableBotInfo);
            _arg_1.addEventListener("RWPIUE_PET_INFO", onPetInfo);
            _arg_1.addEventListener("RWPCUE_PET_COMMANDS", onPetCommands);
            _arg_1.addEventListener("RWPCUE_OPEN_PET_TRAINING", onOpenPetTraining);
            _arg_1.addEventListener("RWPCUE_CLOSE_PET_TRAINING", onClosePetTraining);
            _arg_1.addEventListener("RWSUE_PLAYING_CHANGED", onSongUpdate);
            _arg_1.addEventListener("RWSUE_DATA_RECEIVED", onSongUpdate);
            _arg_1.addEventListener("RWPIUE_PET_FIGURE_UPDATE", onPetFigureUpdate);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWROUE_OBJECT_SELECTED", onRoomObjectSelected);
            _arg_1.removeEventListener("RWROUE_OBJECT_DESELECTED", onClose);
            _arg_1.removeEventListener("RWROUE_USER_REMOVED", onRoomObjectRemoved);
            _arg_1.removeEventListener("RWROUE_FURNI_REMOVED", onRoomObjectRemoved);
            _arg_1.removeEventListener("RWUIUE_OWN_USER", onUserInfo);
            _arg_1.removeEventListener("RWUIUE_PEER", onUserInfo);
            _arg_1.removeEventListener("RWUIUE_BOT", onBotInfo);
            _arg_1.removeEventListener("RWFIUE_FURNI", onFurniInfo);
            _arg_1.removeEventListener("RWPIUE_PET_INFO", onPetInfo);
            _arg_1.removeEventListener("RWPCUE_PET_COMMANDS", onPetCommands);
            _arg_1.removeEventListener("RWPCUE_OPEN_PET_TRAINING", onOpenPetTraining);
            _arg_1.removeEventListener("RWPCUE_CLOSE_PET_TRAINING", onClosePetTraining);
            _arg_1.removeEventListener("RWSUE_PLAYING_CHANGED", onSongUpdate);
            _arg_1.removeEventListener("RWSUE_DATA_RECEIVED", onSongUpdate);
            _arg_1.removeEventListener("RWPIUE_PET_FIGURE_UPDATE", onPetFigureUpdate);
        }

        public function get rentableBotData():InfoStandRentableBotData
        {
            return (_rentableBotData);
        }

        public function get userData():InfoStandUserData
        {
            return (_userData);
        }

        public function get furniData():InfoStandFurniData
        {
            return (_furniData);
        }

        public function get petData():InfoStandPetData
        {
            return (_petData);
        }

        private function onUpdateTimer(_arg_1:TimerEvent):void
        {
            if (_SafeStr_4163 == null)
            {
                return;
            };
            messageListener.processWidgetMessage(new RoomWidgetUserActionMessage("RWUAM_REQUEST_PET_UPDATE", _SafeStr_4163.getCurrentPetId()));
        }

        private function onUserInfo(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            userData.setData(_arg_1);
            _SafeStr_4162.update(_arg_1);
            selectView("infostand_user_view");
            if (_SafeStr_1507)
            {
                _SafeStr_1507.stop();
            };
        }

        private function onBotInfo(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            userData.setData(_arg_1);
            _SafeStr_4164.update(_arg_1);
            selectView("infostand_bot_view");
            if (_SafeStr_1507)
            {
                _SafeStr_1507.stop();
            };
        }

        private function onRentableBotInfo(_arg_1:RoomWidgetRentableBotInfoUpdateEvent):void
        {
            rentableBotData.setData(_arg_1);
            _SafeStr_4165.update(_arg_1);
            selectView("infostand_rentable_bot_view");
            if (_SafeStr_1507)
            {
                _SafeStr_1507.stop();
            };
        }

        private function onFurniInfo(_arg_1:RoomWidgetFurniInfoUpdateEvent):void
        {
            furniData.setData(_arg_1);
            if (_arg_1.extraParam == "RWEIEP_JUKEBOX")
            {
                _SafeStr_4166.update(_arg_1);
                selectView("infostand_jukebox_view");
            }
            else
            {
                if (_arg_1.extraParam.indexOf("RWEIEP_SONGDISK") != -1)
                {
                    _SafeStr_4168.update(_arg_1);
                    selectView("infostand_songdisk_view");
                }
                else
                {
                    if (_arg_1.extraParam.indexOf("RWEIEP_CRACKABLE_FURNI") != -1)
                    {
                        _SafeStr_4167.update(_arg_1);
                        selectView("infostand_crackable_furni_view");
                    }
                    else
                    {
                        _furniView.update(_arg_1);
                        selectView("infostand_furni_view");
                    };
                };
            };
            if (_SafeStr_1507)
            {
                _SafeStr_1507.stop();
            };
        }

        private function onPetInfo(_arg_1:RoomWidgetPetInfoUpdateEvent):void
        {
            petData.setData(_arg_1);
            userData.petRespectLeft = _arg_1.petRespectLeft;
            _SafeStr_4163.update(petData);
            selectView("infostand_pet_view");
            if (_SafeStr_1507)
            {
                _SafeStr_1507.start();
            };
        }

        private function onPetFigureUpdate(_arg_1:RoomWidgetPetFigureUpdateEvent):void
        {
            _SafeStr_4163.updateImage(_arg_1.petId, _arg_1.image);
        }

        private function onPetCommands(_arg_1:RoomWidgetPetCommandsUpdateEvent):void
        {
            var _local_2:Array = _arg_1.allCommands;
            var _local_3:Array = _arg_1.enabledCommands;
            if (((((petData.type == 0) && (!(_config.getBoolean("nest.breeding.dog.enabled")))) || ((petData.type == 1) && (!(_config.getBoolean("nest.breeding.cat.enabled"))))) || ((petData.type == 5) && (!(_config.getBoolean("nest.breeding.pig.enabled"))))))
            {
                if (_local_2.indexOf(46) != -1)
                {
                    _local_2.splice(_local_2.indexOf(46), 1);
                };
                if (_local_3.indexOf(46) != -1)
                {
                    _local_3.splice(_local_3.indexOf(46), 1);
                };
            };
            _SafeStr_4163.updateEnabledTrainingCommands(_arg_1.id, new CommandConfiguration(_arg_1.allCommands, _arg_1.enabledCommands));
        }

        private function onOpenPetTraining(_arg_1:RoomWidgetUpdateEvent):void
        {
            _SafeStr_4163.openTrainView();
        }

        private function onClosePetTraining(_arg_1:RoomWidgetUpdateEvent):void
        {
            _SafeStr_4163.closeTrainView();
        }

        public function updateUserData(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:String, _arg_5:Boolean):void
        {
            if (_arg_1 != userData.userId)
            {
                return;
            };
            if (userData.isBot())
            {
                _SafeStr_4164.setFigure(_arg_2);
            }
            else
            {
                _SafeStr_4162.setFigure(_arg_2);
                _SafeStr_4162.setMotto(_arg_4, _arg_5);
                if (handler.isActivityDisplayEnabled)
                {
                    _SafeStr_4162.achievementScore = _arg_3;
                };
            };
        }

        public function refreshBadges(_arg_1:int, _arg_2:Array):void
        {
            if (_arg_1 != userData.userId)
            {
                return;
            };
            userData.badges = _arg_2;
            if (userData.isBot())
            {
                _SafeStr_4164.clearBadges();
            }
            else
            {
                _SafeStr_4162.clearBadges();
            };
            for each (var _local_3:String in _arg_2)
            {
                refreshBadge(_local_3);
            };
        }

        public function refreshBadge(_arg_1:String):void
        {
            var _local_2:int = userData.badges.indexOf(_arg_1);
            if (_local_2 >= 0)
            {
                if (userData.isBot())
                {
                    _SafeStr_4164.setBadge(_local_2, _arg_1);
                }
                else
                {
                    _SafeStr_4162.setBadge(_local_2, _arg_1);
                };
                return;
            };
            if (_arg_1 == userData.groupBadgeId)
            {
                _SafeStr_4162.setGroupBadge(_arg_1);
            };
        }

        private function onRoomObjectSelected(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            var _local_2:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_INFO", _arg_1.id, _arg_1.category);
            messageListener.processWidgetMessage(_local_2);
        }

        private function onRoomObjectRemoved(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            var _local_2:Boolean;
            switch (_arg_1.type)
            {
                case "RWROUE_FURNI_REMOVED":
                    _local_2 = (_arg_1.id == _furniData.id);
                    break;
                case "RWROUE_USER_REMOVED":
                    if ((((!(_SafeStr_4162 == null)) && (!(_SafeStr_4162.window == null))) && (_SafeStr_4162.window.visible)))
                    {
                        _local_2 = (_arg_1.id == _userData.userRoomId);
                        break;
                    };
                    if ((((!(_SafeStr_4163 == null)) && (!(_SafeStr_4163.window == null))) && (_SafeStr_4163.window.visible)))
                    {
                        _local_2 = (_arg_1.id == _petData.roomIndex);
                        break;
                    };
                    if ((((!(_SafeStr_4164 == null)) && (!(_SafeStr_4164.window == null))) && (_SafeStr_4164.window.visible)))
                    {
                        _local_2 = (_arg_1.id == _userData.userRoomId);
                        break;
                    };
                    if ((((!(_SafeStr_4165 == null)) && (!(_SafeStr_4165.window == null))) && (_SafeStr_4165.window.visible)))
                    {
                        _local_2 = (_arg_1.id == _rentableBotData.userRoomId);
                        break;
                    };
            };
            if (_local_2)
            {
                close();
            };
        }

        private function onSongUpdate(_arg_1:RoomWidgetSongUpdateEvent):void
        {
            _SafeStr_4166.updateSongInfo(_arg_1);
            _SafeStr_4168.updateSongInfo(_arg_1);
        }

        public function close():void
        {
            hideChildren();
            if (_SafeStr_1507)
            {
                _SafeStr_1507.stop();
            };
        }

        private function onClose(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            close();
            if (_SafeStr_1507)
            {
                _SafeStr_1507.stop();
            };
        }

        private function hideChildren():void
        {
            var _local_1:int;
            if (_SafeStr_4170 != null)
            {
                _local_1 = 0;
                while (_local_1 < _SafeStr_4170.numChildren)
                {
                    _SafeStr_4170.getChildAt(_local_1).visible = false;
                    _local_1++;
                };
            };
        }

        public function isFurniViewVisible():Boolean
        {
            var _local_1:IWindow;
            if (_SafeStr_4170 != null)
            {
                _local_1 = (_SafeStr_4170.getChildByName("infostand_furni_view") as IWindow);
                if (_local_1 != null)
                {
                    return (_local_1.visible);
                };
            };
            return (false);
        }

        private function selectView(_arg_1:String):void
        {
            hideChildren();
            var _local_2:IWindow = (mainContainer.getChildByName(_arg_1) as IWindow);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.visible = true;
            mainContainer.visible = true;
            mainContainer.width = _local_2.width;
            mainContainer.height = _local_2.height;
        }

        public function refreshContainer():void
        {
            var _local_2:IWindow;
            var _local_1:int;
            _local_1 = 0;
            while (_local_1 < mainContainer.numChildren)
            {
                _local_2 = mainContainer.getChildAt(_local_1);
                if (_local_2.visible)
                {
                    mainContainer.width = _local_2.width;
                    mainContainer.height = _local_2.height;
                };
                _local_1++;
            };
        }


    }
}

