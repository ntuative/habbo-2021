package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.ITabView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendlist.HabboFriendList;

    public class FriendListTab 
    {

        private var _id:int;
        private var _name:String;
        private var _footerName:String;
        private var _headerPicName:String;
        private var _tabView:ITabView;
        private var _newMessageArrived:Boolean;
        private var _selected:Boolean;
        private var _view:IWindowContainer;

        public function FriendListTab(_arg_1:HabboFriendList, _arg_2:int, _arg_3:ITabView, _arg_4:String, _arg_5:String, _arg_6:String)
        {
            _id = _arg_2;
            _name = _arg_4;
            _tabView = _arg_3;
            _footerName = _arg_5;
            _headerPicName = _arg_6;
            _tabView.init(_arg_1);
        }

        public function setSelected(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                _newMessageArrived = false;
            };
            _selected = _arg_1;
        }

        public function setNewMessageArrived(_arg_1:Boolean):void
        {
            if (selected)
            {
                _newMessageArrived = false;
            }
            else
            {
                _newMessageArrived = _arg_1;
            };
        }

        public function get newMessageArrived():Boolean
        {
            return (_newMessageArrived);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get footerName():String
        {
            return (_footerName);
        }

        public function get headerPicName():String
        {
            return (_headerPicName);
        }

        public function get selected():Boolean
        {
            return (_selected);
        }

        public function get tabView():ITabView
        {
            return (_tabView);
        }

        public function get view():IWindowContainer
        {
            return (_view);
        }

        public function set view(_arg_1:IWindowContainer):void
        {
            _view = _arg_1;
        }


    }
}