package com.sulake.habbo.navigator.roomsettings
{
    import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class BanListCtrl extends UserListCtrl 
    {

        private var _selectedRow:int = -1;

        public function BanListCtrl(_arg_1:IHabboTransitionalNavigator)
        {
            super(_arg_1, false);
        }

        override protected function getRowView():IWindowContainer
        {
            return (IWindowContainer(_navigator.getXmlWindow("ros_banned_user")));
        }

        override protected function onBgMouseClick(_arg_1:WindowEvent):void
        {
            _selectedRow = _arg_1.target.parent.id;
            refreshColorsAfterClick((_arg_1.target.findParentByName("moderation_banned_users") as IItemListWindow));
        }

        override protected function getBgColor(_arg_1:int, _arg_2:Boolean):uint
        {
            if (_arg_1 == _selectedRow)
            {
                return (4288329945);
            };
            return (super.getBgColor(_arg_1, _arg_2));
        }

        private function refreshColorsAfterClick(_arg_1:IItemListWindow):void
        {
            var _local_3:int;
            var _local_2:IWindowContainer;
            _local_3 = 0;
            while (_local_3 < _SafeStr_2335)
            {
                _local_2 = IWindowContainer(_arg_1.getListItemAt(_local_3));
                _local_2.color = this.getBgColor(_local_3, false);
                _local_3++;
            };
        }

        public function get selectedRow():int
        {
            return (_selectedRow);
        }


    }
}

