package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.utils.PropertyStruct;

    public class DropMenuController extends DropBaseController implements IDropMenuWindow 
    {

        private static const DROP_MENU_ITEM_MAX_LENGTH:int = 200;

        private var _stringArray:Array = [];

        public function DropMenuController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }

        override public function dispose():void
        {
            _stringArray = null;
            super.dispose();
        }

        override public function populate(_arg_1:Array):void
        {
            _SafeStr_903 = -1;
            while (_stringArray.length > 0)
            {
                _stringArray.pop();
            };
            var _local_2:uint;
            while (_local_2 < _arg_1.length)
            {
                _stringArray.push(_arg_1[_local_2]);
                _local_2++;
            };
            _menuIsOpen = true;
            closeExpandedMenuView();
        }

        public function populateWithVector(_arg_1:Vector.<String>):void
        {
            _SafeStr_903 = -1;
            while (_stringArray.length > 0)
            {
                _stringArray.pop();
            };
            var _local_2:uint;
            while (_local_2 < _arg_1.length)
            {
                _stringArray.push(_arg_1[_local_2]);
                _local_2++;
            };
            _menuIsOpen = true;
            closeExpandedMenuView();
        }

        override protected function populateExpandedMenu(_arg_1:Vector.<IWindow>, _arg_2:DropBaseController, _arg_3:Function):void
        {
            var _local_5:IDropListItemWindow;
            var _local_12:String;
            if (!_arg_2)
            {
                return;
            };
            var _local_7:IItemListWindow = _arg_2.getItemList();
            _local_7.autoArrangeItems = false;
            _arg_2.getRegion().visible = false;
            var _local_10:uint = _stringArray.length;
            var _local_9:int = _local_7.width;
            var _local_6:int = _local_9;
            var _local_8:int;
            var _local_11:uint;
            while (_local_11 < _local_10)
            {
                _local_12 = _stringArray[_local_11];
                if (_local_12.length > 200)
                {
                    _local_12 = (_local_12.substring(0, 200) + "...");
                };
                _local_5 = (context.create((((name + "::menuItem[") + _local_11) + "]"), _local_12, 103, _style, ((((0x00 | 0x00) | 0x10) | 0x01) | 0x00), null, _arg_3, null, _local_11, null, "", ["_EXCLUDE"]) as DropMenuItemController);
                _itemArray.push(_local_5);
                _local_6 = Math.max(_local_6, _local_5.width);
                _local_8 = (_local_8 + _local_5.height);
                _local_5.width = _local_9;
                _local_7.addListItem(_local_5);
                _local_11++;
            };
            if (_local_6 > _local_9)
            {
                _arg_2.width = (_arg_2.width + (_local_6 - _local_7.width));
                _local_11 = 0;
                while (_local_11 < _local_10)
                {
                    _local_7.getListItemAt(_local_11).width = _local_6;
                    _local_11++;
                };
            };
            var _local_4:IWindow = context.create((name + "::padding"), "", 4, _style, (((0x00 | 0x00) | 0x10) | 0x00), new Rectangle(0, 0, 1, 3), null, null, 0, null, "", ["_EXCLUDE"]);
            _local_7.addListItem(_local_4);
            _local_7.autoArrangeItems = true;
            _local_8 = (_local_8 + _local_4.height);
            _local_8 = (_local_8 + (_local_7.spacing * _local_7.numListItems));
            _arg_2.height = Math.max(_arg_2.height, (_local_8 + 4));
            fitToDesktop(_arg_2);
            _arg_2.activate();
            _local_7.height = Math.max(_local_7.height, (_arg_2.height - 4));
            if (((_SafeStr_903 > -1) && (_local_10)))
            {
                _local_7.getListItemAt(_SafeStr_903).setStateFlag(8, true);
            };
        }

        override protected function closeExpandedMenuView():void
        {
            var _local_1:ILabelWindow;
            if (close())
            {
                if (_SafeStr_904 != null)
                {
                    _SafeStr_904.destroy();
                    _SafeStr_904 = null;
                };
                _menuIsOpen = false;
                while (_itemArray.length > 0)
                {
                    _itemArray.pop().dispose();
                };
                if (!disposed)
                {
                    _local_1 = getTitleLabel();
                    _local_1.visible = true;
                    if (_local_1)
                    {
                        _local_1.text = (((_SafeStr_903 < _stringArray.length) && (_SafeStr_903 > -1)) ? _stringArray[_SafeStr_903] : caption);
                    };
                };
            };
        }

        public function enumerateSelection():Array
        {
            var _local_2:int;
            var _local_1:Array = [];
            if (!_disposed)
            {
                _local_2 = 0;
                while (_local_2 < _stringArray.length)
                {
                    _local_1.push(_stringArray[_local_2]);
                    _local_2++;
                };
            };
            return (_local_1);
        }

        override public function get numMenuItems():int
        {
            return (_stringArray.length);
        }

        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            _local_1.push(createProperty("item_array", _stringArray));
            return (_local_1);
        }

        override public function set properties(_arg_1:Array):void
        {
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "item_array":
                        this.populate((_local_2.value as Array));
                };
            };
            super.properties = _arg_1;
        }


    }
}

