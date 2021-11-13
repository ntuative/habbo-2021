package com.sulake.habbo.ui.widget.crafting
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.RoomUI;
    import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.crafting.controller.CraftingInventoryListController;
    import com.sulake.habbo.ui.widget.crafting.controller.CraftingRecipeListController;
    import com.sulake.habbo.ui.widget.crafting.controller.CraftingMixerController;
    import com.sulake.habbo.ui.widget.crafting.controller.CraftingInfoController;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IItemGridWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.communication.messages.parser.crafting.FurnitureProductItem;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.communication.messages.parser.crafting.OutgoingIngredient;
    import com.sulake.habbo.ui.handler.CraftingWidgetHandler;

    public class CraftingWidget extends RoomWidgetBase 
    {

        public static const MODE_NONE:int = 0;
        public static const MODE_SECRET_RECIPE:int = 1;
        public static const MODE_PUBLIC_RECIPE:int = 2;

        private var _roomUI:RoomUI;
        private var _SafeStr_4014:CraftingFurnitureItem;
        private var _SafeStr_1421:IModalDialog;
        private var _itemTemplate:IWindowContainer;
        private var _inventoryCtrl:CraftingInventoryListController;
        private var _recipeCtrl:CraftingRecipeListController;
        private var _mixerCtrl:CraftingMixerController;
        private var _infoCtrl:CraftingInfoController;
        private var _SafeStr_4015:int = 0;

        public function CraftingWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:RoomUI)
        {
            super(_arg_1, _arg_2, assets, localizations);
            _roomUI = _arg_3;
            _inventoryCtrl = new CraftingInventoryListController(this);
            _recipeCtrl = new CraftingRecipeListController(this);
            _mixerCtrl = new CraftingMixerController(this);
            _infoCtrl = new CraftingInfoController(this);
            _assets = _arg_3.assets;
            this.handler.widget = this;
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            hide();
            _roomUI = null;
            if (_inventoryCtrl)
            {
                _inventoryCtrl.dispose();
                _inventoryCtrl = null;
            };
            if (_recipeCtrl)
            {
                _recipeCtrl.dispose();
                _recipeCtrl = null;
            };
            if (_mixerCtrl)
            {
                _mixerCtrl.dispose();
                _mixerCtrl = null;
            };
            if (_infoCtrl)
            {
                _infoCtrl.dispose();
                _infoCtrl = null;
            };
            if (_itemTemplate)
            {
                _itemTemplate.dispose();
                _itemTemplate = null;
            };
            super.dispose();
        }

        public function hide():void
        {
            handler.removeInventoryUpdateEvent();
            _mixerCtrl.clearItems();
            _inventoryCtrl.clearItems();
            _recipeCtrl.clearItems();
            if (craftingInProgress)
            {
                _infoCtrl.cancelCrafting();
            };
            _SafeStr_4015 = 0;
            if (_SafeStr_1421 != null)
            {
                _SafeStr_1421.dispose();
                _SafeStr_1421 = null;
            };
        }

        private function createMainWindow():void
        {
            if (window != null)
            {
                return;
            };
            _SafeStr_1421 = windowManager.buildModalDialogFromXML(XML(assets.getAssetByName("craftingwidget_xml").content));
            if (((!(_SafeStr_1421)) || (!(_SafeStr_1421.rootWindow))))
            {
                return;
            };
            var _local_2:IWindow = window.findChildByTag("close");
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onClose);
            };
            var _local_1:IItemGridWindow = (window.findChildByName("itemgrid_products") as IItemGridWindow);
            _itemTemplate = (_local_1.getGridItemAt(0) as IWindowContainer);
            _local_1.removeGridItem(_itemTemplate);
            window.procedure = onInput;
            window.center();
        }

        public function populateInventoryItems(_arg_1:Vector.<CraftingFurnitureItem>):void
        {
            _inventoryCtrl.populateInventoryItems(_arg_1);
        }

        public function populateRecipeItems(_arg_1:Vector.<CraftingFurnitureItem>):void
        {
            _recipeCtrl.populateRecipeItems(_arg_1);
        }

        public function setInfoState(_arg_1:int, ... _args):void
        {
            if (_infoCtrl)
            {
                _infoCtrl.setState(_arg_1, _args);
            };
        }

        private function onInput(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_DOWN")
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                    hide();
                    return;
            };
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            hide();
        }

        public function setInfoText(_arg_1:String):void
        {
            var _local_2:ITextWindow = ((window) ? (window.findChildByName("header_mixer") as ITextWindow) : null);
            if (_local_2)
            {
                _local_2.text = _arg_1;
            };
        }

        public function showWidget():void
        {
            if (window)
            {
                return;
            };
            createMainWindow();
            setInfoText("");
            setInfoState(0);
        }

        public function showCraftingCategories(_arg_1:Vector.<FurnitureProductItem>, _arg_2:Vector.<String>, _arg_3:IRoomEngine, _arg_4:ISessionDataManager):void
        {
            var _local_8:Vector.<CraftingFurnitureItem> = undefined;
            var _local_6:String;
            var _local_9:IFurnitureData;
            var _local_10:CraftingFurnitureItem;
            var _local_5:Array;
            _local_8 = new Vector.<CraftingFurnitureItem>(0);
            for each (_local_6 in _arg_2)
            {
                _local_9 = _arg_4.getFloorItemDataByName(_local_6);
                if (_local_9)
                {
                    _local_10 = new CraftingFurnitureItem(null, _local_9);
                    _local_5 = handler.container.inventory.getNonRentedInventoryIds("furni", _local_10.typeId);
                    if (((_local_5) && (_local_5.length > 0)))
                    {
                        _local_10.inventoryIds = Vector.<int>(_local_5);
                    };
                    _local_8.push(_local_10);
                };
            };
            populateInventoryItems(_local_8);
            _local_8 = new Vector.<CraftingFurnitureItem>(0);
            for each (var _local_7:FurnitureProductItem in _arg_1)
            {
                _local_9 = _arg_4.getFloorItemDataByName(_local_7.furnitureClassName);
                if (_local_9)
                {
                    _local_8.push(new CraftingFurnitureItem(_local_7.productCode, _local_9));
                };
            };
            populateRecipeItems(_local_8);
        }

        public function showCraftableProduct(_arg_1:CraftingFurnitureItem):void
        {
            _SafeStr_4014 = _arg_1;
            if (!_SafeStr_4014)
            {
                return;
            };
            setInfoText(((_SafeStr_4014.furnitureData) ? _SafeStr_4014.furnitureData.localizedName : ""));
            handler.getCraftingRecipe(_SafeStr_4014.productCode);
        }

        public function showCraftingRecipe(_arg_1:Vector.<OutgoingIngredient>):void
        {
            showCraftableProductView();
            _recipeCtrl.showRecipe(_SafeStr_4014, _arg_1);
        }

        public function clearMixerItems():void
        {
            if (_mixerCtrl)
            {
                _mixerCtrl.clearItems();
            };
        }

        public function mixerContentChanged(_arg_1:Vector.<int>):void
        {
            if (_arg_1.length > 0)
            {
                setInfoState(1000);
                handler.getCraftingRecipesAvailable(_arg_1);
            }
            else
            {
                setInfoState(1);
            };
        }

        public function showSecretRecipeView():void
        {
            if (_SafeStr_4015 != 1)
            {
                clearMixerItems();
            };
            _SafeStr_4015 = 1;
            setInfoText("");
            setInfoState(1);
        }

        public function showCraftableProductView():void
        {
            if (_SafeStr_4015 != 2)
            {
                clearMixerItems();
            };
            _SafeStr_4015 = 2;
            setInfoState(6);
        }

        public function doCrafting():void
        {
            switch (_SafeStr_4015)
            {
                case 1:
                    handler.doCraftingWithMixer();
                    return;
                case 2:
                    handler.doCraftingWithRecipe();
                default:
            };
        }

        public function getSelectedIngredients():Vector.<int>
        {
            return (_mixerCtrl.collectSelectedFurnitureIds());
        }

        public function get inSecretRecipeMode():Boolean
        {
            return (_SafeStr_4015 == 1);
        }

        public function get craftingInProgress():Boolean
        {
            return (handler.craftingInProgress);
        }

        public function get inventoryDirty():Boolean
        {
            return (handler.inventoryDirty);
        }

        public function get itemTemplate():IWindowContainer
        {
            return (_itemTemplate);
        }

        public function get handler():CraftingWidgetHandler
        {
            return (_SafeStr_3915 as CraftingWidgetHandler);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (handler.container.sessionDataManager);
        }

        public function get inventoryCtrl():CraftingInventoryListController
        {
            return (_inventoryCtrl);
        }

        public function get recipeCtrl():CraftingRecipeListController
        {
            return (_recipeCtrl);
        }

        public function get mixerCtrl():CraftingMixerController
        {
            return (_mixerCtrl);
        }

        public function get infoCtrl():CraftingInfoController
        {
            return (_infoCtrl);
        }

        public function get window():IWindowContainer
        {
            return ((_SafeStr_1421) ? (_SafeStr_1421.rootWindow as IWindowContainer) : null);
        }


    }
}

