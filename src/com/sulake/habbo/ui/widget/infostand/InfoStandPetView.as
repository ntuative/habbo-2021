package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.tracking.HabboTracking;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.core.window.IWidget;
    import com.sulake.habbo.window.widgets.ICountdownWidget;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.widgets.IRarityItemPreviewOverlayWidget;

    public class InfoStandPetView 
    {

        private static const STATUS_BAR_WIDTH:int = 162;
        private static const STATUS_BAR_HEIGTH:int = 16;
        private static const STATUS_BAR_HIGHLIGHT_HEIGHT:int = 4;
        private static const STATUS_BAR_BORDER_COLOR:uint = 0xDADADA;
        private static const STATUS_BAR_BG_COLOR:uint = 0x3A3A3A;
        private static const STATUS_BAR_HAPPINESS_HIGHLIGHT_COLOR:uint = 2085362;
        private static const STATUS_BAR_HAPPINESS_CONTENT_COLOR:uint = 39616;
        private static const STATUS_BAR_EXPERIENCE_HIGHLIGHT_COLOR:uint = 10513106;
        private static const STATUS_BAR_EXPERIENCE_CONTENT_COLOR:uint = 8734654;
        private static const STATUS_BAR_ENERGY_HIGHLIGHT_COLOR:uint = 9094430;
        private static const STATUS_BAR_ENERGY_CONTENT_COLOR:uint = 0x5E9D00;
        private static const STATUS_BAR_WELLBEING_HIGHLIGHT_COLOR:uint = 9094430;
        private static const STATUS_BAR_WELLBEING_CONTENT_COLOR:uint = 0x5E9D00;
        private static const STATE_HAPPINESS:String = "happiness";
        private static const STATE_EXPERIENCE:String = "experience";
        private static const STATE_ENERGY:String = "energy";
        private static const STATE_WELLBEING:String = "wellbeing";
        private static const STATE_GROWTH:String = "growth";
        private static const BUTTONS_MAX_WIDTH:int = 250;
        private static const BUTTON_HEIGHT:int = 25;
        private static const BUTTON_MARGIN:int = 5;

        private var _catalog:IHabboCatalog;
        private var _habboTracking:IHabboTracking;
        private var _SafeStr_1324:InfoStandWidget;
        private var _window:IItemListWindow;
        private var _SafeStr_1276:_SafeStr_124;
        private var _buttonsContainer:IWindowContainer;
        private var _SafeStr_4145:IItemListWindow;
        private var _SafeStr_4155:PetCommandTool;
        private var _SafeStr_3920:Map;
        private var _SafeStr_4156:int;

        public function InfoStandPetView(_arg_1:InfoStandWidget, _arg_2:String, _arg_3:IHabboCatalog)
        {
            _SafeStr_1324 = _arg_1;
            _catalog = _arg_3;
            _habboTracking = HabboTracking.getInstance();
            createWindow(_arg_2);
            _SafeStr_3920 = new Map();
        }

        public function dispose():void
        {
            _SafeStr_1324 = null;
            _catalog = null;
            _habboTracking = null;
            _SafeStr_1276 = null;
            _buttonsContainer = null;
            _SafeStr_4145 = null;
            if (_window)
            {
                _window.dispose();
            };
            _window = null;
            if (_SafeStr_4155)
            {
                _SafeStr_4155.dispose();
            };
            _SafeStr_4155 = null;
            if (_SafeStr_3920)
            {
                _SafeStr_3920.dispose();
                _SafeStr_3920 = null;
            };
        }

        public function get window():IItemListWindow
        {
            return (_window);
        }

        private function updateWindow():void
        {
            if ((((_SafeStr_4145 == null) || (_SafeStr_1276 == null)) || (_buttonsContainer == null)))
            {
                return;
            };
            _buttonsContainer.width = _buttonsContainer.width;
            _buttonsContainer.visible = (_buttonsContainer.width > 0);
            _SafeStr_4145.height = _SafeStr_4145.scrollableRegion.height;
            _SafeStr_1276.height = (_SafeStr_4145.height + 20);
            _window.width = Math.max(_SafeStr_1276.width, _buttonsContainer.width);
            _window.height = _window.scrollableRegion.height;
            if (_SafeStr_1276.width < _buttonsContainer.width)
            {
                _SafeStr_1276.x = (_window.width - _SafeStr_1276.width);
                _buttonsContainer.x = 0;
            }
            else
            {
                _buttonsContainer.x = (_window.width - _buttonsContainer.width);
                _SafeStr_1276.x = 0;
            };
            _SafeStr_1324.refreshContainer();
        }

        public function updateImage(_arg_1:int, _arg_2:BitmapData):void
        {
            if (_SafeStr_4156 == _arg_1)
            {
                image = _arg_2;
                updateWindow();
                updatePetCommandToolImage(_arg_2);
            };
        }

        private function updatePetCommandToolImage(_arg_1:BitmapData):void
        {
            if (_SafeStr_4155 != null)
            {
                _SafeStr_4155.updatePetImage(_arg_1);
            };
        }

        public function update(_arg_1:InfoStandPetData):void
        {
            var _local_3:String;
            var _local_2:Number;
            var _local_5:Number;
            var _local_6:int;
            var _local_4:Number;
            name = _arg_1.name;
            image = _arg_1.image;
            ownerName = _arg_1.ownerName;
            breedText = _SafeStr_1324.localizations.getLocalization(getBreedLocalizationKey(_arg_1.type, _arg_1.breedId));
            updatePetRespect(_arg_1.petRespect, (!(_arg_1.type == 16)));
            ageText = _arg_1.age;
            setLevelText(_arg_1.level, _arg_1.levelMax, (!(_arg_1.type == 16)));
            setSpecialSkillLevel(_arg_1.level, _arg_1.skillTresholds, _arg_1.type);
            setRarityLevel(_arg_1.rarityLevel, _arg_1.type);
            if (_arg_1.type == 16)
            {
                showStatusContainer("default", false);
                showStatusContainer("monsterplant", true);
                _local_3 = _SafeStr_213.formatSeconds(_arg_1.remainingWellBeingSeconds);
                updateStateElement("wellbeing", _arg_1.remainingWellBeingSeconds, _arg_1.maxWellBeingSeconds, 0x5E9D00, 9094430, _local_3);
                updateStateWidget("growth", _arg_1.remainingGrowingSeconds);
                showButton("petrespect", false);
                if (_arg_1.energy > 0)
                {
                    _local_2 = (_arg_1.energy as Number);
                    _local_5 = (_arg_1.energyMax as Number);
                    showButton("pettreat", ((_local_2 / _local_5) < 0.98));
                }
                else
                {
                    showButton("pettreat", false);
                };
                showButton("train", false);
                showButton("buy_food", false);
                showButton("kick", false);
                showButton("pick", _arg_1.canRemovePet);
                showRarityItem((_arg_1.rarityLevel >= 0), _arg_1);
            }
            else
            {
                showStatusContainer("default", true);
                showStatusContainer("monsterplant", false);
                showButton("petrespect", true);
                showButton("pettreat", false);
                showButton("train", _arg_1.isOwnPet);
                showButton("pick", _arg_1.isOwnPet);
                showButton("buy_food", true);
                showButton("kick", _arg_1.canRemovePet);
                updateStateElement("happiness", _arg_1.nutrition, _arg_1.nutritionMax, 39616, 2085362);
                updateStateElement("experience", _arg_1.experience, _arg_1.experienceMax, 8734654, 10513106);
                updateStateElement("energy", _arg_1.energy, _arg_1.energyMax, 0x5E9D00, 9094430);
                updateRespectButton();
            };
            showButton("move", ((_arg_1.isOwnPet) && (_arg_1.type == 16)));
            showButton("rotate", ((_arg_1.isOwnPet) && (_arg_1.type == 16)));
            updateWindow();
            _SafeStr_4156 = _arg_1.id;
            _SafeStr_3920.remove(_arg_1.id);
            _SafeStr_3920.add(_arg_1.id, _arg_1);
            if ((((_SafeStr_4155) && (_SafeStr_4155.isVisible())) && (_arg_1.isOwnPet)))
            {
                _local_6 = getLowerSkillTreshold(_arg_1.level, _arg_1.skillTresholds);
                _local_4 = (_arg_1.experience / _arg_1.experienceMax);
                _SafeStr_4155.showCommandToolForPet(_arg_1.id, _arg_1.name, _arg_1.image, _arg_1.type, (_arg_1.level - _local_6), _local_4, (getUpperSkillTreshold(_arg_1.level, _arg_1.skillTresholds) - _local_6), _arg_1.skillTresholds);
            };
        }

        private function setRarityLevel(_arg_1:int, _arg_2:int):void
        {
            var _local_6:Array = [16, 26];
            var _local_5:String = ((_arg_2 != 16) ? "default" : "monsterplant");
            var _local_3:IItemListWindow = getStatusContainer(_local_5);
            var _local_4:ITextWindow = (_local_3.getListItemByName("status_rarity_level") as ITextWindow);
            if (_local_4 == null)
            {
                return;
            };
            _local_4.visible = (_local_6.indexOf(_arg_2) > -1);
            _SafeStr_1324.localizations.registerParameter("infostand.pet.text.raritylevel", "level", _SafeStr_1324.localizations.getLocalization(("infostand.pet.raritylevel." + _arg_1)));
            updateWindow();
        }

        public function getCurrentPetId():int
        {
            return (_SafeStr_4156);
        }

        public function updateEnabledTrainingCommands(_arg_1:int, _arg_2:CommandConfiguration):void
        {
            if (_SafeStr_4155 == null)
            {
                return;
            };
            _SafeStr_4155.setEnabledCommands(_arg_1, _arg_2);
        }

        private function getBreedLocalizationKey(_arg_1:int, _arg_2:int):String
        {
            return ((("pet.breed." + _arg_1) + ".") + _arg_2);
        }

        private function createPercentageBar(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:uint):BitmapData
        {
            _arg_2 = Math.max(_arg_2, 1);
            _arg_1 = Math.max(_arg_1, 0);
            if (_arg_1 > _arg_2)
            {
                _arg_1 = _arg_2;
            };
            var _local_10:Number = (_arg_1 / _arg_2);
            var _local_9:int = 1;
            var _local_7:BitmapData = new BitmapData(162, 16, false);
            _local_7.fillRect(new Rectangle(0, 0, _local_7.width, _local_7.height), 0xDADADA);
            var _local_8:Rectangle = new Rectangle(_local_9, _local_9, (_local_7.width - (_local_9 * 2)), (_local_7.height - (_local_9 * 2)));
            _local_7.fillRect(_local_8, 0x3A3A3A);
            var _local_6:Rectangle = new Rectangle(_local_9, (_local_9 + 4), (_local_7.width - (_local_9 * 2)), ((_local_7.height - (_local_9 * 2)) - 4));
            _local_6.width = (_local_10 * _local_6.width);
            _local_7.fillRect(_local_6, _arg_3);
            var _local_5:Rectangle = new Rectangle(_local_9, _local_9, (_local_7.width - (_local_9 * 2)), 4);
            _local_5.width = (_local_10 * _local_5.width);
            _local_7.fillRect(_local_5, _arg_4);
            return (_local_7);
        }

        public function openTrainView():void
        {
            var _local_3:int;
            var _local_2:Number;
            if (_SafeStr_4155 == null)
            {
                _SafeStr_4155 = new PetCommandTool(_SafeStr_1324);
            };
            var _local_1:InfoStandPetData = (_SafeStr_3920.getValue(_SafeStr_4156) as InfoStandPetData);
            if (_local_1 != null)
            {
                _SafeStr_4155.showWindow(true);
                _local_3 = getLowerSkillTreshold(_local_1.level, _local_1.skillTresholds);
                _local_2 = (_local_1.experience / _local_1.experienceMax);
                _SafeStr_4155.showCommandToolForPet(_local_1.id, _local_1.name, _local_1.image, _local_1.type, (_local_1.level - _local_3), _local_2, (getUpperSkillTreshold(_local_1.level, _local_1.skillTresholds) - _local_3), _local_1.skillTresholds);
            };
        }

        public function closeTrainView():void
        {
            if (((_SafeStr_4155) && (_SafeStr_4155.getPetId() == _SafeStr_4156)))
            {
                _SafeStr_4155.showWindow(false);
            };
        }

        private function createWindow(_arg_1:String):void
        {
            var _local_22:BitmapDataAsset;
            var _local_20:BitmapData;
            var _local_14:BitmapDataAsset;
            var _local_9:BitmapData;
            var _local_2:BitmapDataAsset;
            var _local_4:BitmapData;
            var _local_11:BitmapDataAsset;
            var _local_3:BitmapData;
            var _local_10:BitmapDataAsset;
            var _local_7:BitmapData;
            var _local_8:BitmapDataAsset;
            var _local_5:BitmapData;
            var _local_18:XmlAsset = (_SafeStr_1324.assets.getAssetByName("pet_view") as XmlAsset);
            _window = (_SafeStr_1324.windowManager.buildFromXML((_local_18.content as XML)) as IItemListWindow);
            if (_window == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            _SafeStr_1276 = (_window.getListItemByName("info_border") as _SafeStr_124);
            if (_SafeStr_1276 != null)
            {
                _SafeStr_4145 = (_SafeStr_1276.findChildByName("infostand_element_list") as IItemListWindow);
            };
            _window.name = _arg_1;
            _SafeStr_1324.mainContainer.addChild(_window);
            var _local_16:IWindow = _SafeStr_1276.findChildByTag("close");
            if (_local_16 != null)
            {
                _local_16.addEventListener("WME_CLICK", onClose);
            };
            _buttonsContainer = (_window.getListItemByName("button_list") as IWindowContainer);
            if (_buttonsContainer == null)
            {
                return;
            };
            var _local_6:Array = [];
            _buttonsContainer.groupChildrenWithTag("CMD_BUTTON", _local_6, -1);
            for each (var _local_15:IWindow in _local_6)
            {
                _local_15.addEventListener("WME_CLICK", onButtonClicked);
            };
            var _local_19:IBitmapWrapperWindow = (_SafeStr_1276.findChildByName("petrespect_icon") as IBitmapWrapperWindow);
            if (_local_19 != null)
            {
                _local_22 = (_SafeStr_1324.assets.getAssetByName("icon_petrespect") as BitmapDataAsset);
                _local_20 = (_local_22.content as BitmapData);
                _local_19.bitmap = _local_20.clone();
            };
            var _local_24:IBitmapWrapperWindow = (_SafeStr_1276.findChildByName("status_happiness_icon") as IBitmapWrapperWindow);
            if (_local_24 != null)
            {
                _local_14 = (_SafeStr_1324.assets.getAssetByName("icon_pet_happiness") as BitmapDataAsset);
                _local_9 = (_local_14.content as BitmapData);
                _local_24.bitmap = _local_9.clone();
            };
            var _local_17:IBitmapWrapperWindow = (_SafeStr_1276.findChildByName("status_experience_icon") as IBitmapWrapperWindow);
            if (_local_17 != null)
            {
                _local_2 = (_SafeStr_1324.assets.getAssetByName("icon_pet_experience") as BitmapDataAsset);
                _local_4 = (_local_2.content as BitmapData);
                _local_17.bitmap = _local_4.clone();
            };
            var _local_21:IBitmapWrapperWindow = (_SafeStr_1276.findChildByName("status_energy_icon") as IBitmapWrapperWindow);
            if (_local_21 != null)
            {
                _local_11 = (_SafeStr_1324.assets.getAssetByName("icon_pet_energy") as BitmapDataAsset);
                _local_3 = (_local_11.content as BitmapData);
                _local_21.bitmap = _local_3.clone();
            };
            var _local_13:IBitmapWrapperWindow = (_SafeStr_1276.findChildByName("skill_level_indicator") as IBitmapWrapperWindow);
            if (_local_13 != null)
            {
                _local_10 = (_SafeStr_1324.assets.getAssetByName("pet_skill_level_0") as BitmapDataAsset);
                _local_7 = (_local_10.content as BitmapData);
                _local_13.bitmap = _local_7.clone();
            };
            var _local_12:IBitmapWrapperWindow = (_SafeStr_1276.findChildByName("status_wellbeing_icon") as IBitmapWrapperWindow);
            if (_local_12 != null)
            {
                _local_8 = (_SafeStr_1324.assets.getAssetByName("icon_pet_wellbeing") as BitmapDataAsset);
                _local_5 = (_local_8.content as BitmapData);
                _local_12.bitmap = _local_5.clone();
            };
            for each (var _local_23:IWindow in _local_6)
            {
                if (_local_23.parent)
                {
                    _local_23.parent.width = _local_23.width;
                };
                _local_23.addEventListener("WE_RESIZED", onButtonResized);
            };
        }

        private function set name(_arg_1:String):void
        {
            if (_SafeStr_4145 == null)
            {
                return;
            };
            var _local_2:ITextWindow = (_SafeStr_4145.getListItemByName("name_text") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.text = _arg_1;
            _local_2.visible = true;
        }

        private function set image(_arg_1:BitmapData):void
        {
            if (_SafeStr_4145 == null)
            {
                return;
            };
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:IWindowContainer = (_SafeStr_4145.getListItemByName("image_container") as IWindowContainer);
            if (_local_2 == null)
            {
                return;
            };
            var _local_4:IBitmapWrapperWindow = (_local_2.findChildByName("avatar_image") as IBitmapWrapperWindow);
            if (_local_4 == null)
            {
                return;
            };
            var _local_3:BitmapData = new BitmapData(_local_4.width, _local_4.height, true, 0);
            var _local_5:Point = new Point(0, 0);
            _local_5.x = Math.round(((_local_4.width - _arg_1.width) / 2));
            _local_5.y = Math.round(((_local_4.height - _arg_1.height) / 2));
            _local_3.copyPixels(_arg_1, _arg_1.rect, _local_5);
            _local_4.bitmap = _local_3;
            _local_4.invalidate();
            updateWindow();
        }

        private function setLevelText(_arg_1:int, _arg_2:int, _arg_3:Boolean=true):void
        {
            if (_SafeStr_4145 == null)
            {
                return;
            };
            var _local_5:IWindowContainer = (_SafeStr_4145.getListItemByName("image_container") as IWindowContainer);
            if (_local_5 == null)
            {
                return;
            };
            var _local_4:ITextWindow = (_local_5.findChildByName("level_text") as ITextWindow);
            if (_local_4 == null)
            {
                return;
            };
            _local_4.visible = _arg_3;
            _SafeStr_1324.localizations.registerParameter("pet.level", "level", _arg_1.toString());
            _SafeStr_1324.localizations.registerParameter("pet.level", "maxlevel", _arg_2.toString());
            updateWindow();
        }

        private function setSpecialSkillLevel(_arg_1:int, _arg_2:Array, _arg_3:int):void
        {
            var _local_9:int;
            var _local_10:BitmapDataAsset;
            var _local_6:BitmapData;
            if (_SafeStr_4145 == null)
            {
                return;
            };
            var _local_4:IWindowContainer = (_SafeStr_4145.getListItemByName("image_container") as IWindowContainer);
            if (_local_4 == null)
            {
                return;
            };
            var _local_5:IWindow = _local_4.findChildByName("status_skill_text");
            _local_5.visible = ((_SafeStr_1324.config.getBoolean("pet.enhancements.enabled")) && (_arg_3 == 15));
            var _local_7:ITextWindow = (_local_4.findChildByName("status_skill_text") as ITextWindow);
            if (_local_7 != null)
            {
                _local_7.caption = (("${infostand.pet.text.skill." + _arg_3) + "}");
            };
            var _local_8:IBitmapWrapperWindow = (_local_4.findChildByName("skill_level_indicator") as IBitmapWrapperWindow);
            if (_local_8 != null)
            {
                _local_8.visible = ((_SafeStr_1324.config.getBoolean("pet.enhancements.enabled")) && (_arg_3 == 15));
                _local_9 = getSkillLevelIndex(_arg_1, _arg_2);
                _local_10 = (_SafeStr_1324.assets.getAssetByName(("pet_skill_level_" + _local_9)) as BitmapDataAsset);
                _local_6 = (_local_10.content as BitmapData);
                _local_8.bitmap = _local_6.clone();
            };
            updateWindow();
        }

        private function set ownerName(_arg_1:String):void
        {
            _SafeStr_1324.localizations.registerParameter("infostand.text.petowner", "name", _arg_1);
            updateWindow();
        }

        private function set breedText(_arg_1:String):void
        {
            if (_SafeStr_4145 == null)
            {
                return;
            };
            var _local_2:ITextWindow = (_SafeStr_4145.getListItemByName("breed_text") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.text = _arg_1;
            updateWindow();
        }

        private function set ageText(_arg_1:int):void
        {
            if (_SafeStr_4145 == null)
            {
                return;
            };
            var _local_2:ITextWindow = (_SafeStr_4145.getListItemByName("age_text") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_1324.localizations.registerParameter("pet.age", "age", _arg_1.toString());
            updateWindow();
        }

        private function updatePetRespect(_arg_1:int, _arg_2:Boolean):void
        {
            _SafeStr_1324.localizations.registerParameter("infostand.text.petrespect", "count", _arg_1.toString());
            if (_SafeStr_4145 == null)
            {
                return;
            };
            var _local_5:IWindowContainer = (_SafeStr_4145.getListItemByName("petrespect_container") as IWindowContainer);
            var _local_3:ITextWindow = (_local_5.findChildByName("petrespect_text") as ITextWindow);
            var _local_4:IBitmapWrapperWindow = (_local_5.findChildByName("petrespect_icon") as IBitmapWrapperWindow);
            _local_3.visible = _arg_2;
            _local_4.visible = _arg_2;
            _local_4.x = ((_local_3.x + _local_3.width) + 2);
            updateWindow();
        }

        private function showStatusContainer(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_3:IItemListWindow = getStatusContainer(_arg_1);
            if (_local_3 != null)
            {
                _local_3.visible = _arg_2;
            };
        }

        private function getStatusContainer(_arg_1:String):IItemListWindow
        {
            if (_SafeStr_4145 == null)
            {
                return (null);
            };
            var _local_2:IWindowContainer = (_SafeStr_4145.getListItemByName("status_container") as IWindowContainer);
            if (_local_2 == null)
            {
                return (null);
            };
            return (_local_2.findChildByName(("status_item_list_" + _arg_1)) as IItemListWindow);
        }

        private function updateStateWidget(_arg_1:String, _arg_2:int):void
        {
            var _local_6:Boolean;
            var _local_9:Boolean;
            var _local_8:ITextWindow;
            var _local_7:IItemListWindow;
            if (_SafeStr_4145 == null)
            {
                return;
            };
            var _local_3:IWindowContainer = (_SafeStr_4145.getListItemByName("status_container") as IWindowContainer);
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:IWidgetWindow = (_local_3.findChildByName((_arg_1 + "_status_widget")) as IWidgetWindow);
            var _local_5:IWidget = _local_4.widget;
            if (_local_5 == null)
            {
                return;
            };
            switch (_arg_1)
            {
                case "growth":
                    (_local_5 as ICountdownWidget).seconds = _arg_2;
                    _local_6 = (_arg_2 > 0);
                    _local_9 = (!(_local_4.visible == _local_6));
                    _local_4.visible = _local_6;
                    _local_8 = (_local_3.findChildByName((_arg_1 + "_status_text")) as ITextWindow);
                    if (_local_8 != null)
                    {
                        _local_8.visible = _local_6;
                    };
                    if (_local_9)
                    {
                        _local_7 = (_local_3.findChildByName("status_item_list_monsterplant") as IItemListWindow);
                        if (_local_7 != null)
                        {
                            _local_7.arrangeListItems();
                        };
                    };
                    return;
                default:
                    return;
            };
        }

        private function updateStateElement(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:uint, _arg_5:uint, _arg_6:String=null):void
        {
            var _local_8:BitmapData;
            if (_SafeStr_4145 == null)
            {
                return;
            };
            var _local_7:IWindowContainer = (_SafeStr_4145.getListItemByName("status_container") as IWindowContainer);
            if (_local_7 == null)
            {
                return;
            };
            var _local_10:ITextWindow = (_local_7.findChildByName((("status_" + _arg_1) + "_value_text")) as ITextWindow);
            if (_local_10 != null)
            {
                _local_10.text = ((_arg_6 != null) ? _arg_6 : ((_arg_2 + "/") + _arg_3));
            };
            var _local_9:IBitmapWrapperWindow = (_local_7.findChildByName((("status_" + _arg_1) + "_bitmap")) as IBitmapWrapperWindow);
            if (_local_9 != null)
            {
                _local_8 = createPercentageBar(_arg_2, _arg_3, _arg_4, _arg_5);
                if (_local_8 != null)
                {
                    _local_9.bitmap = _local_8;
                    _local_9.width = _local_8.width;
                    _local_9.height = _local_8.height;
                    _local_9.invalidate();
                };
            };
            updateWindow();
        }

        protected function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_5:RoomWidgetMessage;
            var _local_6:String;
            var _local_3:String = null;
            var _local_4:int;
            var _local_7:int;
            var _local_8:int;
            var _local_2:IWindow = (_arg_1.target as IWindow);
            switch (_local_2.name)
            {
                case "btn_move":
                    _local_6 = "RWFAM_MOVE";
                    break;
                case "btn_rotate":
                    _local_6 = "RWFUAM_ROTATE";
                    break;
                case "btn_pick":
                    _local_6 = "RWUAM_PICKUP_PET";
                    if (((_SafeStr_4155) && (_SafeStr_4155.getPetId() == _SafeStr_4156)))
                    {
                        _SafeStr_4155.showWindow(false);
                    };
                    break;
                case "btn_kick":
                    _local_6 = "RWUAM_PICKUP_PET";
                    if (((_SafeStr_4155) && (_SafeStr_4155.getPetId() == _SafeStr_4156)))
                    {
                        _SafeStr_4155.showWindow(false);
                    };
                    break;
                case "btn_train":
                    openTrainView();
                    break;
                case "btn_buy_food":
                    if (_catalog)
                    {
                        _catalog.openCatalogPage("pet_accessories");
                        if (((_habboTracking) && (!(_habboTracking.disposed))))
                        {
                            _habboTracking.trackGoogle("infostandBuyPetFoodButton", "click");
                        };
                    };
                    break;
                case "btn_petrespect":
                    _SafeStr_1324.userData.petRespectLeft = (_SafeStr_1324.userData.petRespectLeft - 1);
                    updateRespectButton();
                    _local_6 = " RWUAM_RESPECT_PET";
                    break;
                case "btn_pettreat":
                    _local_6 = "RWUAM_TREAT_PET";
            };
            if (_local_6 != null)
            {
                if (((_local_6 == "RWFAM_MOVE") || (_local_6 == "RWFUAM_ROTATE")))
                {
                    _local_4 = _SafeStr_1324.petData.roomIndex;
                    _local_7 = 100;
                    _local_5 = new RoomWidgetFurniActionMessage(_local_6, _local_4, _local_7, -1, _local_3);
                    _SafeStr_1324.messageListener.processWidgetMessage(_local_5);
                }
                else
                {
                    _local_8 = _SafeStr_1324.petData.id;
                    _local_5 = new RoomWidgetUserActionMessage(_local_6, _local_8);
                    _SafeStr_1324.messageListener.processWidgetMessage(_local_5);
                };
            };
            updateWindow();
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.close();
        }

        private function updateRespectButton():void
        {
            var _local_1:int = _SafeStr_1324.userData.petRespectLeft;
            _SafeStr_1324.localizations.registerParameter("infostand.button.petrespect", "count", _local_1.toString());
            showButton("petrespect", (_local_1 > 0));
        }

        protected function showButton(_arg_1:String, _arg_2:Boolean):void
        {
            if (_buttonsContainer == null)
            {
                return;
            };
            var _local_3:IWindow = _buttonsContainer.getChildByName(_arg_1);
            if (_local_3 != null)
            {
                _local_3.visible = _arg_2;
                arrangeButtons();
            };
        }

        protected function onButtonResized(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.window.parent;
            if (((_local_2) && (_local_2.tags.indexOf("CMD_BUTTON_REGION") > -1)))
            {
                _local_2.width = _arg_1.window.width;
            };
        }

        private function arrangeButtons():void
        {
            var _local_5:Number = 250;
            _buttonsContainer.width = _local_5;
            var _local_2:Array = [];
            _buttonsContainer.groupChildrenWithTag("CMD_BUTTON_REGION", _local_2, -1);
            var _local_1:Number = _local_5;
            var _local_3:int;
            for each (var _local_4:IWindow in _local_2)
            {
                if (_local_4.visible)
                {
                    if ((_local_1 - _local_4.width) < 0)
                    {
                        _local_1 = _local_5;
                        _local_3 = (_local_3 + (25 + 5));
                    };
                    _local_4.x = (_local_1 - _local_4.width);
                    _local_4.y = _local_3;
                    _local_1 = (_local_4.x - 5);
                };
            };
            _buttonsContainer.height = (_local_3 + 25);
            updateWindow();
        }

        private function getSkillLevelIndex(_arg_1:int, _arg_2:Array):int
        {
            var _local_3:int;
            for each (var _local_4:int in _arg_2)
            {
                if (((_local_4 > 0) && (_arg_1 >= _local_4)))
                {
                    _local_3++;
                };
            };
            return (_local_3);
        }

        private function getLowerSkillTreshold(_arg_1:int, _arg_2:Array):int
        {
            var _local_3:int;
            for each (var _local_4:int in _arg_2)
            {
                if (_local_4 <= _arg_1)
                {
                    _local_3 = _local_4;
                }
                else
                {
                    break;
                };
            };
            return (_local_3);
        }

        private function getUpperSkillTreshold(_arg_1:int, _arg_2:Array):int
        {
            var _local_5:int = getLowerSkillTreshold(_arg_1, _arg_2);
            var _local_4:int = _arg_2.indexOf(_local_5);
            var _local_3:int = _local_5;
            if (_local_4 < (_arg_2.length - 1))
            {
                _local_3 = _arg_2[(_local_4 + 1)];
            };
            return (_local_3);
        }

        private function showRarityItem(_arg_1:Boolean, _arg_2:InfoStandPetData):void
        {
            if (_SafeStr_4145 == null)
            {
                return;
            };
            var _local_3:IWindowContainer = (_SafeStr_4145.getListItemByName("status_container") as IWindowContainer);
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:IWidgetWindow = (_local_3.findChildByName("rarity_item_overlay_widget") as IWidgetWindow);
            var _local_6:IWidget = _local_4.widget;
            if (_local_6 == null)
            {
                return;
            };
            var _local_5:IRarityItemPreviewOverlayWidget = IRarityItemPreviewOverlayWidget(_local_6);
            _local_5.rarityLevel = _arg_2.rarityLevel;
        }


    }
}

