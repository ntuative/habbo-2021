package com.sulake.habbo.avatar
{
    import com.sulake.habbo.avatar.structure.IFigureSetData;
    import com.sulake.core.utils.Map;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.common.ISideContentModel;
    import com.sulake.habbo.avatar.wardrobe.WardrobeModel;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.habbo.avatar.generic.BodyModel;
    import com.sulake.habbo.avatar.head.HeadModel;
    import com.sulake.habbo.avatar.torso.TorsoModel;
    import com.sulake.habbo.avatar.legs.LegsModel;
    import com.sulake.habbo.avatar.hotlooks.HotLooksModel;
    import com.sulake.habbo.avatar.effects.EffectsModel;
    import com.sulake.habbo.avatar.structure.figure.ISetType;
    import com.sulake.habbo.avatar.structure.figure.IPalette;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.register.UpdateFigureDataMessageComposer;
    import com.sulake.habbo.avatar.events.AvatarUpdateEvent;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import com.sulake.habbo.avatar.common.AvatarEditorGridPartItem;
    import com.sulake.habbo.avatar.common.AvatarEditorGridColorItem;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.common.CategoryData;

    public class HabboAvatarEditor 
    {

        private static const DEFAULT_MALE_FIGURE:String = "hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007";
        private static const DEFAULT_FEMALE_FIGURE:String = "hr-515-33.hd-600-1.ch-635-70.lg-716-66-62.sh-735-68";
        private static const MAX_COLOR_LAYERS:int = 2;

        private var _instanceId:uint;
        private var _manager:HabboAvatarEditorManager;
        private var _SafeStr_1406:IFigureSetData;
        private var _view:AvatarEditorView;
        private var _SafeStr_573:Boolean = false;
        private var _SafeStr_575:Map;
        private var _SafeStr_1407:Map;
        private var _SafeStr_1408:Dictionary;
        private var _gender:String = "M";
        private var _figureString:String;
        private var _SafeStr_1409:IHabboAvatarEditorDataSaver = null;
        private var _SafeStr_1410:Boolean = false;
        private var _SafeStr_1411:Boolean = false;
        private var _SafeStr_1412:int;
        private var _SafeStr_1413:Boolean = false;

        public function HabboAvatarEditor(_arg_1:uint, _arg_2:HabboAvatarEditorManager, _arg_3:Boolean=false)
        {
            _instanceId = _arg_1;
            _manager = _arg_2;
            _SafeStr_1406 = _manager.avatarRenderManager.getFigureData();
            _SafeStr_1413 = _arg_3;
        }

        public function dispose():void
        {
            if (_SafeStr_575 != null)
            {
                for each (var _local_2:IAvatarEditorCategoryModel in _SafeStr_575)
                {
                    _local_2.dispose();
                    _local_2 = null;
                };
                _SafeStr_575 = null;
            };
            if (_SafeStr_1407 != null)
            {
                for each (var _local_1:ISideContentModel in _SafeStr_1407)
                {
                    _local_1.dispose();
                    _local_1 = null;
                };
                _SafeStr_1407 = null;
            };
            if (_view != null)
            {
                _view.dispose();
                _view = null;
            };
            _SafeStr_1406 = null;
            _SafeStr_1408 = null;
            _SafeStr_1409 = null;
        }

        private function init(_arg_1:Array=null):void
        {
            if (_SafeStr_573)
            {
                return;
            };
            _SafeStr_575 = new Map();
            _SafeStr_1407 = new Map();
            _SafeStr_1407.add("wardrobe", new WardrobeModel(this));
            _view = new AvatarEditorView(this, _arg_1);
            _SafeStr_1408 = new Dictionary();
            _SafeStr_1408["M"] = new FigureData(this);
            _SafeStr_1408["F"] = new FigureData(this);
            var _local_3:FigureData = _SafeStr_1408["M"];
            var _local_2:FigureData = _SafeStr_1408["F"];
            _local_3.loadAvatarData("hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007", "M");
            _local_2.loadAvatarData("hr-515-33.hd-600-1.ch-635-70.lg-716-66-62.sh-735-68", "F");
            _SafeStr_575.add("generic", new BodyModel(this));
            _SafeStr_575.add("head", new HeadModel(this));
            _SafeStr_575.add("torso", new TorsoModel(this));
            _SafeStr_575.add("legs", new LegsModel(this));
            if (((_arg_1 == null) || (_arg_1.indexOf("hotlooks") > -1)))
            {
                _SafeStr_575.add("hotlooks", new HotLooksModel(this));
            };
            _SafeStr_575.add("effects", new EffectsModel(this));
            _SafeStr_573 = true;
        }

        public function loadAvatarInEditor(_arg_1:String, _arg_2:String, _arg_3:int=0):void
        {
            switch (_arg_2)
            {
                case "M":
                case "m":
                case "M":
                    _arg_2 = "M";
                    break;
                case "F":
                case "f":
                case "F":
                    _arg_2 = "F";
                    break;
                default:
                    _arg_2 = "M";
            };
            this.clubMemberLevel = _arg_3;
            var _local_4:Boolean;
            var _local_5:FigureData = _SafeStr_1408[_arg_2];
            if (_local_5 == null)
            {
                return;
            };
            _local_5.loadAvatarData(_arg_1, _arg_2);
            if (_arg_2 != this.gender)
            {
                this.gender = _arg_2;
                _local_4 = true;
            };
            if (_figureString != _arg_1)
            {
                _figureString = _arg_1;
                _local_4 = true;
            };
            if (((_SafeStr_575) && (_local_4)))
            {
                for each (var _local_6:IAvatarEditorCategoryModel in _SafeStr_575)
                {
                    _local_6.reset();
                };
            };
            if (_view != null)
            {
                _view.update();
            };
        }

        public function getFigureSetType(_arg_1:String):ISetType
        {
            if (_SafeStr_1406 == null)
            {
                return (null);
            };
            return (_SafeStr_1406.getSetType(_arg_1));
        }

        public function getPalette(_arg_1:int):IPalette
        {
            if (_SafeStr_1406 == null)
            {
                return (null);
            };
            return (_SafeStr_1406.getPalette(_arg_1));
        }

        public function openWindow(_arg_1:IHabboAvatarEditorDataSaver, _arg_2:Array=null, _arg_3:Boolean=false, _arg_4:String=null, _arg_5:String="generic"):IFrameWindow
        {
            _SafeStr_1409 = _arg_1;
            _SafeStr_1410 = _arg_3;
            init(_arg_2);
            selectDefaultCategory(_arg_2, _arg_5);
            return (_view.getFrame(_arg_2, _arg_4));
        }

        public function embedToContext(_arg_1:IWindowContainer=null, _arg_2:IHabboAvatarEditorDataSaver=null, _arg_3:Array=null, _arg_4:Boolean=false):Boolean
        {
            _SafeStr_1409 = _arg_2;
            _SafeStr_1410 = _arg_4;
            init(_arg_3);
            _view.embedToContext(_arg_1, _arg_3);
            selectDefaultCategory(_arg_3);
            return (true);
        }

        private function selectDefaultCategory(_arg_1:Array, _arg_2:String="generic"):void
        {
            var _local_3:Boolean = ((!(_arg_1 == null)) && (_arg_1.length > 0));
            if (((!(_arg_2 == null)) && ((!(_local_3)) || (_arg_1.indexOf(_arg_2) >= 0))))
            {
                toggleAvatarEditorPage(_arg_2);
            }
            else
            {
                if (_local_3)
                {
                    toggleAvatarEditorPage(_arg_1[0]);
                }
                else
                {
                    toggleAvatarEditorPage("generic");
                };
            };
        }

        public function get instanceId():uint
        {
            return (_instanceId);
        }

        public function hide():void
        {
            _view.hide();
        }

        public function getCategoryWindowContainer(_arg_1:String):IWindow
        {
            var _local_2:IAvatarEditorCategoryModel = (_SafeStr_575.getValue(_arg_1) as IAvatarEditorCategoryModel);
            if (_local_2 != null)
            {
                return (_local_2.getWindowContainer());
            };
            return (null);
        }

        public function activateCategory(_arg_1:String):void
        {
            var _local_2:IAvatarEditorCategoryModel = (_SafeStr_575.getValue(_arg_1) as IAvatarEditorCategoryModel);
            if (_local_2)
            {
                _local_2.switchCategory();
            };
        }

        public function getSideContentWindowContainer(_arg_1:String):IWindowContainer
        {
            var _local_2:ISideContentModel = (_SafeStr_1407.getValue(_arg_1) as ISideContentModel);
            if (_local_2 != null)
            {
                return (_local_2.getWindowContainer());
            };
            return (null);
        }

        public function toggleAvatarEditorPage(_arg_1:String):void
        {
            if (_view)
            {
                _view.toggleCategoryView(_arg_1, false);
            };
        }

        public function useClubClothing():void
        {
            if (_SafeStr_575 == null)
            {
                return;
            };
            update();
        }

        public function disableClubClothing():void
        {
            if (_SafeStr_575 == null)
            {
                return;
            };
            update();
        }

        public function get figureData():FigureData
        {
            return (_SafeStr_1408[_gender]);
        }

        public function saveCurrentSelection():void
        {
            var _local_3:UpdateFigureDataMessageComposer;
            var _local_1:String = figureData.getFigureString();
            var _local_2:String = figureData.gender;
            if (_SafeStr_1409 != null)
            {
                _SafeStr_1409.saveFigure(_local_1, _local_2);
            }
            else
            {
                _local_3 = new UpdateFigureDataMessageComposer(_local_1, _local_2);
                _manager.communication.connection.send(_local_3);
                _manager.events.dispatchEvent(new AvatarUpdateEvent(_local_1));
                _local_3.dispose();
                _local_3 = null;
                if (_SafeStr_1411)
                {
                    if (figureData.avatarEffectType != -1)
                    {
                        _manager.inventory.setEffectSelected(figureData.avatarEffectType);
                    }
                    else
                    {
                        _manager.inventory.deselectAllEffects(true);
                    };
                };
                _SafeStr_1411 = false;
            };
        }

        public function generateDataContent(_arg_1:IAvatarEditorCategoryModel, _arg_2:String):CategoryData
        {
            var _local_21:int;
            var _local_14:IFigurePartSet;
            var _local_9:AvatarEditorGridPartItem;
            var _local_22:ISetType;
            var _local_10:IPalette;
            var _local_13:Array;
            var _local_12:Array;
            var _local_19:Boolean;
            var _local_11:int;
            var _local_15:Boolean;
            var _local_18:AvatarEditorGridColorItem;
            var _local_26:int;
            var _local_30:Array;
            var _local_17:int;
            var _local_32:Boolean;
            var _local_33:BitmapDataAsset;
            var _local_25:BitmapData;
            var _local_24:IWindowContainer;
            var _local_29:Boolean;
            var _local_31:Map;
            var _local_16:int;
            var _local_27:int;
            var _local_6:Boolean;
            var _local_34:Boolean;
            var _local_3:Boolean;
            var _local_20:BitmapDataAsset;
            var _local_23:BitmapData;
            var _local_7:IWindowContainer;
            var _local_5:Array;
            if (!_arg_1)
            {
                return (null);
            };
            if (!_arg_2)
            {
                return (null);
            };
            var _local_4:Array = [];
            var _local_8:Array = [];
            _local_21 = 0;
            while (_local_21 < 2)
            {
                _local_8.push([]);
                _local_21++;
            };
            _local_22 = getFigureSetType(_arg_2);
            if (!_local_22)
            {
                return (null);
            };
            if (_local_22 != null)
            {
                _local_10 = getPalette(_local_22.paletteID);
                if (!_local_10)
                {
                    return (null);
                };
                _local_13 = figureData.getColourIds(_arg_2);
                if (!_local_13)
                {
                    _local_13 = [];
                };
                _local_12 = new Array(_local_13.length);
                _local_19 = showClubItemsDimmedConfiguration();
                for each (var _local_28:IPartColor in _local_10.colors)
                {
                    if (((_local_28.isSelectable) && ((_local_19) || (clubMemberLevel >= _local_28.clubLevel))))
                    {
                        _local_11 = 0;
                        while (_local_11 < 2)
                        {
                            _local_15 = (clubMemberLevel < _local_28.clubLevel);
                            _local_18 = new AvatarEditorGridColorItem((AvatarEditorView.COLOUR_WINDOW.clone() as IWindowContainer), _arg_1, _local_28, _local_15);
                            _local_8[_local_11].push(_local_18);
                            _local_11++;
                        };
                        if (_arg_2 != "hd")
                        {
                            _local_26 = 0;
                            while (_local_26 < _local_13.length)
                            {
                                if (_local_28.id == _local_13[_local_26])
                                {
                                    _local_12[_local_26] = _local_28;
                                };
                                _local_26++;
                            };
                        };
                    };
                };
                if (_local_19)
                {
                    _local_17 = 2;
                    _local_30 = _manager.avatarRenderManager.getMandatoryAvatarPartSetIds(gender, _local_17);
                }
                else
                {
                    _local_30 = _manager.avatarRenderManager.getMandatoryAvatarPartSetIds(gender, clubMemberLevel);
                };
                _local_32 = (_local_30.indexOf(_arg_2) == -1);
                if (_local_32)
                {
                    _local_33 = (_manager.windowManager.assets.getAssetByName("avatar_editor_generic_remove_selection") as BitmapDataAsset);
                    _local_25 = (_local_33.content as BitmapData).clone();
                    _local_24 = (AvatarEditorView.THUMB_WINDOW.clone() as IWindowContainer);
                    _local_24.name = "REMOVE_ITEM";
                    _local_9 = new AvatarEditorGridPartItem(_local_24, _arg_1, null, null, false);
                    _local_9.iconImage = _local_25;
                    _local_4.push(_local_9);
                };
                _local_29 = (!(_arg_2 == "hd"));
                _local_31 = _local_22.partSets;
                _local_16 = _local_31.length;
                _local_27 = (_local_16 - 1);
                while (_local_27 >= 0)
                {
                    _local_14 = _local_31.getWithIndex(_local_27);
                    _local_6 = false;
                    if (_local_14.gender == "U")
                    {
                        _local_6 = true;
                    }
                    else
                    {
                        if (_local_14.gender == gender)
                        {
                            _local_6 = true;
                        };
                    };
                    if ((((_local_14.isSelectable) && (_local_6)) && ((_local_19) || (clubMemberLevel >= _local_14.clubLevel))))
                    {
                        _local_34 = (clubMemberLevel < _local_14.clubLevel);
                        _local_3 = true;
                        if (_local_14.isSellable)
                        {
                            _local_3 = (((manager.inventory) && (_manager.inventory.hasFigureSetIdInInventory(_local_14.id))) || (isDevelopmentEditor()));
                        };
                        if (_local_3)
                        {
                            _local_9 = new AvatarEditorGridPartItem((AvatarEditorView.THUMB_WINDOW.clone() as IWindowContainer), _arg_1, _local_14, _local_12, _local_29, _local_34);
                            _local_4.push(_local_9);
                        };
                    };
                    _local_27--;
                };
            };
            _local_4.sort(((showClubItemsFirst) ? orderByClubDesc : orderByClubAsc));
            if (((_SafeStr_1413) || (_manager.getBoolean("avatareditor.support.sellablefurni"))))
            {
                _local_20 = (_manager.windowManager.assets.getAssetByName("camera_zoom_in") as BitmapDataAsset);
                _local_23 = (_local_20.content as BitmapData).clone();
                _local_7 = (AvatarEditorView.THUMB_WINDOW.clone() as IWindowContainer);
                _local_7.name = "GET_MORE";
                _local_9 = new AvatarEditorGridPartItem(_local_7, _arg_1, null, null, false);
                _local_9.iconImage = _local_23;
                _local_4.push(_local_9);
            };
            _local_21 = 0;
            while (_local_21 < 2)
            {
                _local_5 = (_local_8[_local_21] as Array);
                _local_5.sort(orderPaletteByClub);
                _local_21++;
            };
            return (new CategoryData(_local_4, _local_8));
        }

        public function isSideContentEnabled():Boolean
        {
            return (_SafeStr_1410);
        }

        public function hasInvalidClubItems():Boolean
        {
            var _local_1:Boolean;
            for each (var _local_2:IAvatarEditorCategoryModel in _SafeStr_575.getValues())
            {
                _local_1 = _local_2.hasClubItemsOverLevel(clubMemberLevel);
                if (_local_1)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function hasInvalidSellableItems():Boolean
        {
            var _local_1:Boolean;
            for each (var _local_2:IAvatarEditorCategoryModel in _SafeStr_575.getValues())
            {
                _local_1 = _local_2.hasInvalidSellableItems(_manager.inventory);
                if (_local_1)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function stripClubItems():void
        {
            for each (var _local_1:IAvatarEditorCategoryModel in _SafeStr_575.getValues())
            {
                _local_1.stripClubItemsOverLevel(clubMemberLevel);
            };
            figureData.updateView();
        }

        public function stripInvalidSellableItems():void
        {
            for each (var _local_1:IAvatarEditorCategoryModel in _SafeStr_575.getValues())
            {
                _local_1.stripInvalidSellableItems();
            };
            figureData.updateView();
        }

        public function getDefaultColour(_arg_1:String):int
        {
            var _local_3:IPalette;
            var _local_2:ISetType = getFigureSetType(_arg_1);
            if (_local_2 != null)
            {
                _local_3 = getPalette(_local_2.paletteID);
                for each (var _local_4:IPartColor in _local_3.colors)
                {
                    if (((_local_4.isSelectable) && (clubMemberLevel >= _local_4.clubLevel)))
                    {
                        return (_local_4.id);
                    };
                };
            };
            return (-1);
        }

        private function orderByClubAsc(_arg_1:AvatarEditorGridPartItem, _arg_2:AvatarEditorGridPartItem):Number
        {
            var _local_4:Number = ((_arg_1.partSet == null) ? -1 : _arg_1.partSet.clubLevel);
            var _local_5:Number = ((_arg_2.partSet == null) ? -1 : _arg_2.partSet.clubLevel);
            var _local_6:Boolean = ((_arg_1.partSet == null) ? false : _arg_1.partSet.isSellable);
            var _local_3:Boolean = ((_arg_2.partSet == null) ? false : _arg_2.partSet.isSellable);
            if (((_local_6) && (!(_local_3))))
            {
                return (1);
            };
            if (((_local_3) && (!(_local_6))))
            {
                return (-1);
            };
            if (_local_4 < _local_5)
            {
                return (-1);
            };
            if (_local_4 > _local_5)
            {
                return (1);
            };
            if (_arg_1.partSet.id < _arg_2.partSet.id)
            {
                return (-1);
            };
            if (_arg_1.partSet.id > _arg_2.partSet.id)
            {
                return (1);
            };
            return (0);
        }

        private function orderByClubDesc(_arg_1:AvatarEditorGridPartItem, _arg_2:AvatarEditorGridPartItem):Number
        {
            var _local_4:Number = ((_arg_1.partSet == null) ? 9999999999 : _arg_1.partSet.clubLevel);
            var _local_5:Number = ((_arg_2.partSet == null) ? 9999999999 : _arg_2.partSet.clubLevel);
            var _local_6:Boolean = ((_arg_1.partSet == null) ? false : _arg_1.partSet.isSellable);
            var _local_3:Boolean = ((_arg_2.partSet == null) ? false : _arg_2.partSet.isSellable);
            if (((_local_6) && (!(_local_3))))
            {
                return (1);
            };
            if (((_local_3) && (!(_local_6))))
            {
                return (-1);
            };
            if (_local_4 > _local_5)
            {
                return (-1);
            };
            if (_local_4 < _local_5)
            {
                return (1);
            };
            if (_arg_1.partSet.id > _arg_2.partSet.id)
            {
                return (-1);
            };
            if (_arg_1.partSet.id < _arg_2.partSet.id)
            {
                return (1);
            };
            return (0);
        }

        private function orderPaletteByClub(_arg_1:AvatarEditorGridColorItem, _arg_2:AvatarEditorGridColorItem):Number
        {
            var _local_3:Number = ((_arg_1.partColor == null) ? -1 : (_arg_1.partColor.clubLevel as Number));
            var _local_4:Number = ((_arg_2.partColor == null) ? -1 : (_arg_2.partColor.clubLevel as Number));
            if (_local_3 < _local_4)
            {
                return (-1);
            };
            if (_local_3 > _local_4)
            {
                return (1);
            };
            if (_arg_1.partColor.index < _arg_2.partColor.index)
            {
                return (-1);
            };
            if (_arg_1.partColor.index > _arg_2.partColor.index)
            {
                return (1);
            };
            return (0);
        }

        public function get gender():String
        {
            return (_gender);
        }

        public function set gender(_arg_1:String):void
        {
            if (_gender == _arg_1)
            {
                return;
            };
            _gender = _arg_1;
            for each (var _local_2:IAvatarEditorCategoryModel in _SafeStr_575)
            {
                _local_2.reset();
            };
            if (_view != null)
            {
                _view.update();
            };
        }

        public function get handler():AvatarEditorMessageHandler
        {
            return (_manager.handler);
        }

        public function get wardrobe():WardrobeModel
        {
            if (!_SafeStr_573)
            {
                return (null);
            };
            return (_SafeStr_1407.getValue("wardrobe"));
        }

        public function get effects():EffectsModel
        {
            if (!_SafeStr_573)
            {
                return (null);
            };
            return (_SafeStr_575.getValue("effects"));
        }

        public function set clubMemberLevel(_arg_1:int):void
        {
            _SafeStr_1412 = _arg_1;
        }

        public function get clubMemberLevel():int
        {
            if (!_SafeStr_1412)
            {
                return (_manager.sessionData.clubLevel);
            };
            return (_SafeStr_1412);
        }

        public function verifyClubLevel():Boolean
        {
            return (_manager.catalog.verifyClubLevel());
        }

        private function get showClubItemsFirst():Boolean
        {
            return (_manager.getBoolean("avatareditor.show.clubitems.first"));
        }

        private function showClubItemsDimmedConfiguration():Boolean
        {
            return (_manager.getBoolean("avatareditor.show.clubitems.dimmed"));
        }

        public function get manager():HabboAvatarEditorManager
        {
            return (_manager);
        }

        public function update():void
        {
            var _local_1:IAvatarEditorCategoryModel;
            var _local_2:ISideContentModel;
            for each (_local_1 in _SafeStr_575)
            {
                _local_1.reset();
            };
            for each (_local_2 in _SafeStr_1407)
            {
                _local_2.reset();
            };
            if (_view)
            {
                _view.update();
            };
        }

        public function setAvatarEffectType(_arg_1:int):void
        {
            figureData.avatarEffectType = _arg_1;
            figureData.updateView();
            _SafeStr_1411 = true;
        }

        public function get view():AvatarEditorView
        {
            return (_view);
        }

        public function openHabboClubAdWindow():void
        {
            if (_manager.catalog)
            {
                _manager.catalog.openClubCenter();
            };
        }

        public function isDevelopmentEditor():Boolean
        {
            return (_instanceId == 3);
        }


    }
}

