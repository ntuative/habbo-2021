package com.sulake.habbo.navigator.roomsettings
{
    import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.navigator.domain.RoomLayout;
    import flash.utils.Timer;
    import com.sulake.habbo.navigator.TextFieldManager;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.events.Event;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.navigator.Util;
    import flash.geom.Rectangle;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CreateFlatMessageComposer;
    import com.sulake.habbo.navigator.*;

    public class RoomCreateViewCtrl 
    {

        private static const ROOM_LIMIT_HC:int = 75;
        private static const ROOM_LIMIT_NON_SUBSCRIBER:int = 50;

        private var _navigator:IHabboTransitionalNavigator;
        private var _content:IWindowContainer;
        private var _SafeStr_853:IItemListWindow;
        private var _layouts:Vector.<RoomLayout>;
        private var _selectedLayout:RoomLayout;
        private var _SafeStr_2938:Timer;
        private var _SafeStr_2939:Boolean = true;
        private var _SafeStr_2940:TextFieldManager;
        private var _SafeStr_2941:TextFieldManager;
        private var _SafeStr_1612:IDropMenuWindow;
        private var _maxVisitors:IDropMenuWindow;
        private var _SafeStr_2942:IDropMenuWindow;
        private var _SafeStr_2943:Array = [];

        public function RoomCreateViewCtrl(_arg_1:IHabboTransitionalNavigator)
        {
            _navigator = _arg_1;
            _SafeStr_2938 = new Timer(100);
            _SafeStr_2938.addEventListener("timer", updateArrowPos);
            _layouts = new Vector.<RoomLayout>();
            _layouts.push(new RoomLayout(0, 104, "a"));
            _layouts.push(new RoomLayout(0, 94, "b"));
            _layouts.push(new RoomLayout(0, 36, "c"));
            _layouts.push(new RoomLayout(0, 84, "d"));
            _layouts.push(new RoomLayout(0, 80, "e"));
            _layouts.push(new RoomLayout(0, 80, "f"));
            _layouts.push(new RoomLayout(0, 416, "i"));
            _layouts.push(new RoomLayout(0, 320, "j"));
            _layouts.push(new RoomLayout(0, 448, "k"));
            _layouts.push(new RoomLayout(0, 352, "l"));
            _layouts.push(new RoomLayout(0, 384, "m"));
            _layouts.push(new RoomLayout(0, 372, "n"));
            _layouts.push(new RoomLayout(1, 80, "g"));
            _layouts.push(new RoomLayout(1, 74, "h"));
            _layouts.push(new RoomLayout(1, 416, "o"));
            _layouts.push(new RoomLayout(1, 352, "p"));
            _layouts.push(new RoomLayout(1, 304, "q"));
            _layouts.push(new RoomLayout(1, 336, "r"));
            _layouts.push(new RoomLayout(1, 748, "u"));
            _layouts.push(new RoomLayout(1, 438, "v"));
            _layouts.push(new RoomLayout(2, 540, "t"));
            _layouts.push(new RoomLayout(2, 0x0200, "w"));
            _layouts.push(new RoomLayout(2, 396, "x"));
            _layouts.push(new RoomLayout(2, 440, "y"));
            _layouts.push(new RoomLayout(2, 456, "z"));
            _layouts.push(new RoomLayout(2, 208, "0"));
            _layouts.push(new RoomLayout(2, 1009, "1"));
            _layouts.push(new RoomLayout(2, 1044, "2"));
            _layouts.push(new RoomLayout(2, 183, "3"));
            _layouts.push(new RoomLayout(2, 254, "4"));
            _layouts.push(new RoomLayout(2, 0x0400, "5"));
            _layouts.push(new RoomLayout(2, 801, "6"));
            _layouts.push(new RoomLayout(2, 354, "7"));
            _layouts.push(new RoomLayout(2, 888, "8"));
            _layouts.push(new RoomLayout(2, 926, "9"));
            _layouts.push(new RoomLayout(-1, 2500, "snowwar1"));
            _layouts.push(new RoomLayout(-1, 2500, "snowwar2"));
        }

        private static function addMouseClickListener(_arg_1:IWindow, _arg_2:Function):void
        {
            if (_arg_1 != null)
            {
                _arg_1.setParamFlag(1, true);
                _arg_1.addEventListener("WME_CLICK", _arg_2);
            };
        }


        public function dispose():void
        {
            if (_SafeStr_2938)
            {
                _SafeStr_2938.removeEventListener("timer", updateArrowPos);
                _SafeStr_2938.reset();
                _SafeStr_2938 = null;
            };
        }

        private function updateArrowPos(_arg_1:Event):void
        {
            var _local_5:String = "select_arrow";
            var _local_3:IBitmapWrapperWindow = IBitmapWrapperWindow(_selectedLayout.view.findChildByName(_local_5));
            var _local_2:int;
            var _local_6:int = 15;
            var _local_4:int = (((Math.abs((_local_3.y - _local_2)) < 2) || (Math.abs((_local_3.y - _local_6)) < 2)) ? 1 : 2);
            _local_3.y = (_local_3.y + ((_SafeStr_2939) ? _local_4 : -(_local_4)));
            if (_local_3.y < _local_2)
            {
                _SafeStr_2939 = true;
                _local_3.y = (_local_2 + 1);
            }
            else
            {
                if (_local_3.y > _local_6)
                {
                    _SafeStr_2939 = false;
                    _local_3.y = (_local_6 - 1);
                };
            };
        }

        public function hide():void
        {
            if (_content)
            {
                _content.visible = false;
            };
        }

        public function show():void
        {
            this.prepare();
            this._content.visible = true;
            this.refresh();
            this._content.activate();
            this._SafeStr_2938.start();
        }

        private function prepare():void
        {
            if (this._content != null)
            {
                return;
            };
            _content = IWindowContainer(_navigator.getXmlWindow("roc_create_room"));
            _SafeStr_853 = IItemListWindow(_content.findChildByName("layout_item_list"));
            refreshRoomThumbnails();
            var _local_4:_SafeStr_101 = getCreateButton();
            addMouseClickListener(_local_4, onCreateButtonClick);
            var _local_1:_SafeStr_101 = getCancelButton();
            addMouseClickListener(_local_1, onCancelButtonClick);
            var _local_3:IWindow = _content.findChildByTag("close");
            addMouseClickListener(_local_3, onCancelButtonClick);
            _SafeStr_2940 = new TextFieldManager(_navigator, ITextFieldWindow(_content.findChildByName("room_name_input")), 25, null, _navigator.getText("navigator.createroom.roomnameinfo"));
            _SafeStr_2941 = new TextFieldManager(_navigator, ITextFieldWindow(_content.findChildByName("room_desc_input")), 128, null, _navigator.getText("navigator.createroom.roomdescinfo"));
            prepareCategorySelection();
            prepareTradeModeSelection();
            refreshMaxVisitors(50);
            var _local_2:Rectangle = Util.getLocationRelativeTo(_content.desktop, _content.width, _content.height);
            _content.x = _local_2.x;
            _content.y = _local_2.y;
        }

        private function prepareCategorySelection():void
        {
            _SafeStr_1612 = (_content.findChildByName("categories_list") as IDropMenuWindow);
            var _local_1:Array = [];
            _SafeStr_2943 = [];
            for each (var _local_2:FlatCategory in _navigator.data.visibleCategories)
            {
                if (((!(_local_2.automatic)) && ((!(_local_2.staffOnly)) || ((_local_2.staffOnly) && (_navigator.sessionData.hasSecurity(7))))))
                {
                    _SafeStr_2943.push(_local_2);
                    _local_1.push(_local_2.visibleName);
                };
            };
            _SafeStr_1612.populate(_local_1);
            _SafeStr_1612.selection = 0;
        }

        private function prepareTradeModeSelection():void
        {
            _SafeStr_2942 = (_content.findChildByName("trade_settings_list") as IDropMenuWindow);
            var _local_1:Array = [];
            _local_1.push("${navigator.roomsettings.trade_not_allowed}");
            _local_1.push("${navigator.roomsettings.trade_not_with_Controller}");
            _local_1.push("${navigator.roomsettings.trade_allowed}");
            _SafeStr_2942.populate(_local_1);
            _SafeStr_2942.selection = 0;
        }

        public function refresh():void
        {
            _SafeStr_2940.goBackToInitialState();
            _SafeStr_2940.input.textBackgroundColor = 0xFFFFFFFF;
            _SafeStr_2941.goBackToInitialState();
            _SafeStr_2941.input.textBackgroundColor = 0xFFFFFFFF;
            _SafeStr_2942.selection = 0;
            _SafeStr_1612.selection = 0;
            _selectedLayout = _layouts[0];
            this.refreshRoomThumbnails();
            if (_navigator.sessionData.hasVip)
            {
                refreshMaxVisitors(75);
            }
            else
            {
                refreshMaxVisitors(50);
            };
            refreshSelection();
        }

        private function refreshMaxVisitors(_arg_1:int):void
        {
            var _local_2:int;
            _maxVisitors = (_content.findChildByName("visitors_list") as IDropMenuWindow);
            var _local_3:Array = [];
            _local_2 = 10;
            while (_local_2 <= _arg_1)
            {
                _local_3.push(("" + _local_2));
                _local_2 = (_local_2 + 5);
            };
            _maxVisitors.populate(_local_3);
            _maxVisitors.selection = 0;
        }

        private function refreshSelection():void
        {
            var _local_2:Boolean;
            var _local_3:ITextWindow;
            for each (var _local_1:RoomLayout in _layouts)
            {
                if (_local_1.view != null)
                {
                    _local_2 = (_local_1 == _selectedLayout);
                    _local_1.view.findChildByName("bg_sel").visible = _local_2;
                    _local_1.view.findChildByName("bg_unsel").visible = (!(_local_2));
                    _local_3 = ITextWindow(_local_1.view.findChildByName("tile_size_txt"));
                    _local_3.textColor = ((_local_2) ? 0xFFFFFFFF : 0xFF000000);
                    _local_3.color = ((_local_2) ? 4285432196 : 4291546059);
                    _navigator.refreshButton(_local_1.view, "tile_icon_black", (!(_local_2)), null, 0);
                    _navigator.refreshButton(_local_1.view, "tile_icon_white", _local_2, null, 0);
                    _navigator.refreshButton(_local_1.view, "select_arrow", _local_2, null, 0);
                };
            };
        }

        private function refreshRoomThumbnails():void
        {
            var _local_9:IWindow;
            var _local_6:IWindowContainer;
            var _local_5:int;
            var _local_1:RoomLayout;
            var _local_2:IWindowContainer;
            var _local_4:IWindow;
            while (_SafeStr_853.numListItems > 0)
            {
                _local_9 = _SafeStr_853.removeListItemAt(0);
                _local_9.destroy();
            };
            for each (var _local_7:RoomLayout in _layouts)
            {
                if (_local_7.view != null)
                {
                    _local_7.view.destroy();
                    _local_7.view = null;
                };
            };
            var _local_3:int;
            _local_5 = 0;
            while (_local_5 < _layouts.length)
            {
                _local_1 = _layouts[_local_5];
                if (isAllowed(_local_1, false))
                {
                    if (_local_3 == 0)
                    {
                        _local_6 = getRow();
                        _SafeStr_853.addListItem(_local_6);
                    };
                    addThumbnail(_local_6, _layouts[_local_5], ((_local_3 % 2) == 0));
                    _local_3 = ((_local_3 == 0) ? 1 : 0);
                };
                _local_5++;
            };
            refreshSelection();
            var _local_8:String;
            if (((_navigator.sessionData.clubLevel < 2) && (!(_navigator.getBoolean("habbo_club_buy_disabled")))))
            {
                _local_8 = "roc_vip_promo";
            };
            if (_local_8 != null)
            {
                _local_2 = IWindowContainer(_navigator.getXmlWindow(_local_8));
                if (_local_2)
                {
                    _local_4 = _local_2.findChildByName("link");
                    addMouseClickListener(_local_4, onHcMoreClick);
                    _SafeStr_853.addListItem(_local_2);
                };
            };
        }

        private function addThumbnail(_arg_1:IWindowContainer, _arg_2:RoomLayout, _arg_3:Boolean):void
        {
            var _local_5:IWindowContainer = IWindowContainer(_navigator.getXmlWindow("roc_room_thumbnail"));
            _local_5.tags.push(_arg_2.name);
            if (!_arg_3)
            {
                _local_5.x = _local_5.width;
            };
            addMouseClickListener(_local_5, onContPicClick);
            var _local_4:IStaticBitmapWrapperWindow = (_local_5.findChildByName("bg_pic") as IStaticBitmapWrapperWindow);
            _local_4.assetUri = (("${image.library.url}newroom/model_" + _arg_2.name) + ".png");
            _arg_1.addChild(_local_5);
            (_navigator.sessionData.clubLevel >= 2);
            _arg_1.width = (2 * _local_5.width);
            _arg_1.height = _local_5.height;
            _arg_2.view = _local_5;
            ITextWindow(_arg_2.view.findChildByName("tile_size_txt")).text = ((_arg_2.tileSize + " ") + _navigator.getText("navigator.createroom.tilesize"));
            _local_5.findChildByName("club_icon").visible = ((_arg_2.requiredClubLevel == 1) || (_arg_2.requiredClubLevel == 2));
        }

        private function isAllowed(_arg_1:RoomLayout, _arg_2:Boolean=true):Boolean
        {
            switch (_arg_1.requiredClubLevel)
            {
                case 0:
                    return (true);
                case 1:
                    return ((!(_arg_2)) || (_navigator.sessionData.hasClub));
                case 2:
                    return ((!(_arg_2)) || (_navigator.sessionData.hasVip));
                default:
                    return (_navigator.sessionData.hasSecurity(4));
            };
        }

        private function getRow():IWindowContainer
        {
            return (IWindowContainer(_navigator.windowManager.createWindow("", "", 4, 0, 16, new Rectangle(0, 0, 100, 300))));
        }

        private function isMandatoryFieldsFilled():Boolean
        {
            return (_SafeStr_2940.checkMandatory(_navigator.getText("navigator.createroom.nameerr")));
        }

        private function getCreateButton():_SafeStr_101
        {
            return (_SafeStr_101(_content.findChildByName("create_button")));
        }

        private function getCancelButton():_SafeStr_101
        {
            return (_SafeStr_101(_content.findChildByName("back_button")));
        }

        private function onChooseLayout(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:RoomLayout = getLayout(_arg_2);
            if (isAllowed(_local_3, true))
            {
                _selectedLayout = _local_3;
                refreshSelection();
            }
            else
            {
                _navigator.openCatalogClubPage("RoomCreateViewCtrl");
            };
        }

        private function getLayout(_arg_1:IWindow):RoomLayout
        {
            return (findLayout(_arg_1.tags[0]));
        }

        private function findLayout(_arg_1:String):RoomLayout
        {
            for each (var _local_2:RoomLayout in _layouts)
            {
                if (_local_2.name == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (_layouts[0]);
        }

        private function onContPicClick(_arg_1:WindowEvent):void
        {
            var _local_2:IWindowContainer = (_arg_1.target as IWindowContainer);
            onChooseLayout(_arg_1, _local_2);
        }

        private function onCancelButtonClick(_arg_1:WindowEvent):void
        {
            close();
        }

        private function onHcMoreClick(_arg_1:WindowEvent):void
        {
            Logger.log("HC LINK CLICKED");
            _navigator.openCatalogClubPage("RoomCreateViewCtrl");
        }

        private function onCreateButtonClick(_arg_1:WindowEvent):void
        {
            var _local_8:String = _SafeStr_2940.getText();
            var _local_3:String = _SafeStr_2941.getText();
            var _local_5:String = ("model_" + _selectedLayout.name);
            var _local_2:int = parseInt(_maxVisitors.enumerateSelection()[_maxVisitors.selection]);
            var _local_9:int;
            var _local_4:int;
            for each (var _local_7:FlatCategory in _SafeStr_2943)
            {
                if (_SafeStr_1612.selection == _local_4)
                {
                    _local_9 = _local_7.nodeId;
                    break;
                };
                _local_4++;
            };
            var _local_6:int = _SafeStr_2942.selection;
            if (!isMandatoryFieldsFilled())
            {
                return;
            };
            _navigator.send(new CreateFlatMessageComposer(_local_8, _local_3, _local_5, _local_9, _local_2, _local_6));
        }

        private function close():void
        {
            this._content.visible = false;
            this._SafeStr_2938.reset();
        }


    }
}

