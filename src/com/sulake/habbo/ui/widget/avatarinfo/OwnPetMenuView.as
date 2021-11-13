package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPetCommandMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class OwnPetMenuView extends AvatarContextInfoButtonView 
    {

        private static const MODE_NORMAL:int = 0;
        private static const MODE_SADDLED_UP:int = 1;
        private static const MODE_RIDING:int = 2;
        private static const MODE_MONSTERPLANT:int = 3;

        private var _SafeStr_690:PetInfoData;
        private var _SafeStr_1493:int;
        private var _SafeStr_3935:IFurnitureData;
        private var _SafeStr_3936:IFurnitureData;
        protected var _catalog:IHabboCatalog;
        protected var _habboTracking:IHabboTracking;

        public function OwnPetMenuView(_arg_1:AvatarInfoWidget, _arg_2:IHabboCatalog)
        {
            super(_arg_1);
            _SafeStr_3885 = false;
            _habboTracking = HabboTracking.getInstance();
            _catalog = _arg_2;
        }

        public static function setup(_arg_1:OwnPetMenuView, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:PetInfoData):void
        {
            _arg_1._SafeStr_690 = _arg_6;
            var _local_7:Boolean = _arg_1.widget.hasFreeSaddle;
            var _local_8:Boolean = _arg_1.widget.isRiding;
            if (_arg_1.widget.isMonsterPlant())
            {
                _arg_1._SafeStr_1493 = 3;
            }
            else
            {
                if (((_local_7) && (!(_local_8))))
                {
                    _arg_1._SafeStr_1493 = 1;
                }
                else
                {
                    if (_local_8)
                    {
                        _arg_1._SafeStr_1493 = 2;
                    }
                    else
                    {
                        _arg_1._SafeStr_1493 = 0;
                    };
                };
            };
            AvatarContextInfoButtonView.setup(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, false);
        }


        override public function dispose():void
        {
            _SafeStr_690 = null;
            _SafeStr_3935 = null;
            _SafeStr_3936 = null;
            _catalog = null;
            _habboTracking = null;
            super.dispose();
        }

        override protected function updateWindow():void
        {
            var _local_1:XML;
            if ((((!(_SafeStr_1324)) || (!(_SafeStr_1324.assets))) || (!(_SafeStr_1324.windowManager))))
            {
                return;
            };
            if (_SafeStr_2776)
            {
                activeView = getMinimizedView();
            }
            else
            {
                if (!_window)
                {
                    _local_1 = (XmlAsset(_SafeStr_1324.assets.getAssetByName("own_pet_menu")).content as XML);
                    _window = (_SafeStr_1324.windowManager.buildFromXML(_local_1, 0) as IWindowContainer);
                    if (!_window)
                    {
                        return;
                    };
                    _window.addEventListener("WME_OVER", onMouseHoverEvent);
                    _window.addEventListener("WME_OUT", onMouseHoverEvent);
                    _window.findChildByName("minimize").addEventListener("WME_CLICK", onMinimize);
                    _window.findChildByName("minimize").addEventListener("WME_OVER", onMinimizeHover);
                    _window.findChildByName("minimize").addEventListener("WME_OUT", onMinimizeHover);
                };
                _buttons = (_window.findChildByName("buttons") as IItemListWindow);
                _buttons.procedure = buttonEventProc;
                _window.findChildByName("name").caption = _userName;
                _window.visible = false;
                activeView = _window;
                updateButtons();
            };
        }

        public function updateButtons():void
        {
            var _local_6:int;
            var _local_2:Number;
            var _local_7:Number;
            var _local_3:int;
            var _local_8:IRoomObject;
            var _local_4:int;
            if ((((!(_window)) || (!(_SafeStr_690))) || (!(_buttons))))
            {
                return;
            };
            _buttons.autoArrangeItems = false;
            var _local_5:int = _buttons.numListItems;
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                _buttons.getListItemAt(_local_6).visible = false;
                _local_6++;
            };
            _SafeStr_3935 = null;
            var _local_1:AvatarInfoWidgetHandler = widget.handler;
            switch (_SafeStr_1493)
            {
                case 0:
                    showButton("respect", (_SafeStr_690.petRespectLeft > 0));
                    showButton("train");
                    showButton("pick_up");
                    if (_SafeStr_690.petType == 15)
                    {
                        _SafeStr_3935 = findFurnitureData(16, 15);
                        if (_SafeStr_3935 != null)
                        {
                            showButton("buy_saddle");
                        };
                    };
                    if (widget.configuration.getBoolean("nest.breeding.bear.enabled"))
                    {
                        if (_SafeStr_690.petType == 4)
                        {
                            showButton("breed");
                        };
                    };
                    if (widget.configuration.getBoolean("nest.breeding.terrier.enabled"))
                    {
                        if (_SafeStr_690.petType == 3)
                        {
                            showButton("breed");
                        };
                    };
                    if (widget.configuration.getBoolean("nest.breeding.cat.enabled"))
                    {
                        if (_SafeStr_690.petType == 1)
                        {
                            showButton("breed");
                        };
                    };
                    if (widget.configuration.getBoolean("nest.breeding.dog.enabled"))
                    {
                        if (_SafeStr_690.petType == 0)
                        {
                            showButton("breed");
                        };
                    };
                    if (widget.configuration.getBoolean("nest.breeding.pig.enabled"))
                    {
                        if (_SafeStr_690.petType == 5)
                        {
                            showButton("breed");
                        };
                    };
                    break;
                case 1:
                    showButton("mount");
                    if (widget.configuration.getBoolean("sharedhorseriding.enabled"))
                    {
                        showButton("toggle_riding_permission");
                        enableCheckbox("toggle_riding_permission", ((_SafeStr_690 != null) ? (_SafeStr_690.accessRights == 1) : false));
                    };
                    showButton("respect", (_SafeStr_690.petRespectLeft > 0));
                    showButton("train");
                    showButton("pick_up");
                    showButton("saddle_off");
                    break;
                case 2:
                    showButton("dismount");
                    showButton("respect", (_SafeStr_690.petRespectLeft > 0));
                    break;
                case 3:
                    showButton("pick_up");
                    if (_SafeStr_690.canRevive)
                    {
                        _SafeStr_3936 = findFurnitureData(20, 16);
                        showButton("revive");
                        if (((widget.configuration.getBoolean("monsterplants.composting.enabled")) && (_local_1.container.roomSession.isRoomOwner)))
                        {
                            showButton("compost");
                        };
                    }
                    else
                    {
                        _local_2 = (_SafeStr_690.energy as Number);
                        _local_7 = (_SafeStr_690.energyMax as Number);
                        showButton("treat", true, ((_local_2 / _local_7) < 0.98));
                        if (_SafeStr_690.level == _SafeStr_690.levelMax)
                        {
                            if (_SafeStr_690.canBreed)
                            {
                                showButton("toggle_breeding_permission");
                                enableCheckbox("toggle_breeding_permission", _SafeStr_690.hasBreedingPermission);
                                showButton("breed");
                            };
                        };
                    };
                default:
            };
            if (widget.configuration.getBoolean("handitem.give.pet.enabled"))
            {
                _local_3 = _local_1.container.roomSession.ownUserRoomId;
                _local_8 = _local_1.container.roomEngine.getRoomObject(_local_1.roomSession.roomId, _local_3, 100);
                if (_local_8 != null)
                {
                    _local_4 = _local_8.getModel().getNumber("figure_carry_object");
                    if (((_local_4 > 0) && (_local_4 < 999999)))
                    {
                        showButton("pass_handitem");
                    };
                };
            };
            widget.localizations.registerParameter("infostand.button.petrespect", "count", _SafeStr_690.petRespectLeft.toString());
            _buttons.autoArrangeItems = true;
            _buttons.visible = true;
        }

        private function findFurnitureData(_arg_1:int, _arg_2:int):IFurnitureData
        {
            var _local_3:Array;
            var _local_6:int;
            var _local_4:IFurnitureData;
            var _local_7:Array = widget.handler.container.sessionDataManager.getFloorItemsDataByCategory(_arg_1);
            for each (var _local_5:IFurnitureData in _local_7)
            {
                _local_3 = _local_5.customParams.split(" ");
                _local_6 = (((_local_3) && (_local_3.length >= 1)) ? parseInt(_local_3[0]) : -1);
                if (_local_6 == _arg_2)
                {
                    _local_4 = _local_5;
                    break;
                };
            };
            return (_local_4);
        }

        private function openCatalogPage(_arg_1:IFurnitureData):Boolean
        {
            if ((((_catalog == null) || (_arg_1 == null)) || (_arg_1.purchaseOfferId < 0)))
            {
                return (false);
            };
            _catalog.openCatalogPageByOfferId(_arg_1.purchaseOfferId, "NORMAL");
            if (((_habboTracking) && (!(_habboTracking.disposed))))
            {
                _habboTracking.trackGoogle("infostandCatalogButton", "offer", _arg_1.purchaseOfferId);
            };
            return (true);
        }

        private function findRoomObject(_arg_1:IFurnitureData):IRoomObject
        {
            var _local_5:int;
            var _local_3:IRoomObject;
            var _local_7:int;
            if (((widget == null) || (_arg_1 == null)))
            {
                return (null);
            };
            var _local_2:IRoomWidgetHandlerContainer = widget.handler.container;
            if (_local_2 == null)
            {
                return (null);
            };
            var _local_6:IRoomEngine = _local_2.roomEngine;
            if (_local_6 == null)
            {
                return (null);
            };
            var _local_8:int = _local_2.roomSession.roomId;
            var _local_4:int = _local_6.getRoomObjectCount(_local_8, 10);
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_3 = _local_6.getRoomObjectWithIndex(_local_8, _local_5, 10);
                if (_local_3 != null)
                {
                    _local_7 = _local_3.getModel().getNumber("furniture_type_id");
                    if (_local_7 == _arg_1.id)
                    {
                        return (_local_3);
                    };
                };
                _local_5++;
            };
            return (null);
        }

        private function enableCheckbox(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_3:_SafeStr_108 = getCheckbox(_arg_1);
            if (!_local_3)
            {
                return;
            };
            if (_arg_2)
            {
                _local_3.select();
            }
            else
            {
                _local_3.unselect();
            };
        }

        private function getCheckbox(_arg_1:String):_SafeStr_108
        {
            if (!_buttons)
            {
                return (null);
            };
            var _local_2:IWindowContainer = (_buttons.getListItemByName(_arg_1) as IWindowContainer);
            if (!_local_2)
            {
                return (null);
            };
            return (_local_2.findChildByName((_arg_1 + "_checkbox")) as _SafeStr_108);
        }

        override protected function buttonEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_8:RoomWidgetMessage;
            var _local_5:_SafeStr_108;
            var _local_9:int;
            var _local_6:String;
            var _local_4:String;
            var _local_7:Boolean;
            if (disposed)
            {
                return;
            };
            if (((!(_window)) || (_window.disposed)))
            {
                return;
            };
            var _local_3:Boolean;
            if (_arg_1.type == "WME_CLICK")
            {
                if (_arg_2.name == "button")
                {
                    _local_3 = true;
                    Logger.log(("Own pet menu was clicked: " + _arg_2.parent.name));
                    switch (_arg_2.parent.name)
                    {
                        case "respect":
                            _SafeStr_690.petRespectLeft = (_SafeStr_690.petRespectLeft - 1);
                            updateButtons();
                            _local_8 = new RoomWidgetUserActionMessage(" RWUAM_RESPECT_PET", petId);
                            break;
                        case "treat":
                            _local_8 = new RoomWidgetUserActionMessage("RWUAM_TREAT_PET", petId);
                            break;
                        case "pass_handitem":
                            _local_8 = new RoomWidgetUserActionMessage("RWUAM_GIVE_CARRY_ITEM_TO_PET", petId);
                            break;
                        case "train":
                            widget.openTrainingView();
                            break;
                        case "pick_up":
                            _local_8 = new RoomWidgetUserActionMessage("RWUAM_PICKUP_PET", petId);
                            widget.closeTrainingView();
                            break;
                        case "mount":
                            _local_8 = new RoomWidgetUserActionMessage("RWUAM_MOUNT_PET", petId);
                            break;
                        case "toggle_riding_permission":
                            _local_8 = new RoomWidgetUserActionMessage("RWUAM_TOGGLE_PET_RIDING_PERMISSION", petId);
                            _local_5 = getCheckbox("toggle_riding_permission");
                            if (_local_5 != null)
                            {
                                enableCheckbox("toggle_riding_permission", (!(_local_5.isSelected)));
                            };
                            break;
                        case "toggle_breeding_permission":
                            _local_8 = new RoomWidgetUserActionMessage("RWUAM_TOGGLE_PET_BREEDING_PERMISSION", petId);
                            _local_5 = getCheckbox("toggle_breeding_permission");
                            if (_local_5 != null)
                            {
                                enableCheckbox("toggle_breeding_permission", (!(_local_5.isSelected)));
                            };
                            break;
                        case "dismount":
                            _local_8 = new RoomWidgetUserActionMessage("RWUAM_DISMOUNT_PET", petId);
                            break;
                        case "saddle_off":
                            _local_8 = new RoomWidgetUserActionMessage("RWUAM_SADDLE_OFF", petId);
                            break;
                        case "breed":
                            if (_SafeStr_1493 == 0)
                            {
                                _local_9 = 46;
                                _local_6 = ("pet.command." + _local_9);
                                _local_4 = _SafeStr_1324.catalog.localization.getLocalization(_local_6);
                                _local_8 = new RoomWidgetPetCommandMessage("RWPCM_PET_COMMAND", _SafeStr_690.id, ((_SafeStr_690.name + " ") + _local_4));
                            }
                            else
                            {
                                if (_SafeStr_1493 == 3)
                                {
                                    _local_8 = new RoomWidgetUserActionMessage("RWUAM_REQUEST_BREED_PET", petId);
                                };
                            };
                            break;
                        case "harvest":
                            _local_8 = new RoomWidgetUserActionMessage("RWUAM_HARVEST_PET", petId);
                            break;
                        case "revive":
                            _local_7 = openCatalogPage(_SafeStr_3936);
                            if (!_local_7)
                            {
                            };
                            _local_8 = new RoomWidgetUserActionMessage("RWUAM_REVIVE_PET", petId);
                            break;
                        case "compost":
                            _local_8 = new RoomWidgetUserActionMessage("RWUAM_COMPOST_PLANT", petId);
                            break;
                        case "buy_saddle":
                            openCatalogPage(_SafeStr_3935);
                    };
                }
                else
                {
                    if (_arg_2.name == "profile_link")
                    {
                        _local_8 = new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE", petId, "ownPetContextMenu");
                    }
                    else
                    {
                        if (_arg_2.name == "toggle_riding_permission_checkbox")
                        {
                            _local_3 = true;
                            _local_8 = new RoomWidgetUserActionMessage("RWUAM_TOGGLE_PET_RIDING_PERMISSION", petId);
                        }
                        else
                        {
                            if (_arg_2.name == "toggle_breeding_permission_checkbox")
                            {
                                _local_3 = true;
                                _local_8 = new RoomWidgetUserActionMessage("RWUAM_TOGGLE_PET_BREEDING_PERMISSION", petId);
                            };
                        };
                    };
                };
                if (_local_8)
                {
                    _SafeStr_1324.messageListener.processWidgetMessage(_local_8);
                };
            }
            else
            {
                super.buttonEventProc(_arg_1, _arg_2);
            };
            if (_local_3)
            {
                _SafeStr_1324.removeView(this, false);
            };
        }

        public function get widget():AvatarInfoWidget
        {
            return (_SafeStr_1324 as AvatarInfoWidget);
        }

        private function changeMode(_arg_1:int):void
        {
            _SafeStr_1493 = _arg_1;
            updateButtons();
        }

        public function get petId():int
        {
            return (userId);
        }


    }
}

