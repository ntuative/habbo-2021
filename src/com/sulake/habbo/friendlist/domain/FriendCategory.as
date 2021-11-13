package com.sulake.habbo.friendlist.domain
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendlist.Util;

    public class FriendCategory implements IDisposable 
    {

        public static const PAGE_SIZE:int = 100;
        public static const CATID_ONLINE:int = 0;
        public static const CATID_OFFLINE:int = -1;

        private var _id:int;
        private var _name:String;
        private var _open:Boolean;
        private var _friends:Array = [];
        private var _received:Boolean;
        private var _disposed:Boolean;
        private var _view:IWindowContainer;
        private var _pageIndex:int;

        public function FriendCategory(_arg_1:int, _arg_2:String)
        {
            _id = _arg_1;
            _name = _arg_2;
            _open = (!(_id == -1));
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            _view = null;
        }

        public function addFriend(_arg_1:Friend):void
        {
            removeFriend(_arg_1.id);
            _friends.push(_arg_1);
            _friends.sortOn(["pocketHabboUser", "name"], [(0x10 | 0x02), 1]);
        }

        public function getSelectedFriends(_arg_1:Array):void
        {
            for each (var _local_2:Friend in _friends)
            {
                if (_local_2.selected)
                {
                    _arg_1.push(_local_2);
                };
            };
        }

        public function getFriend(_arg_1:int):Friend
        {
            for each (var _local_2:Friend in _friends)
            {
                if (_local_2.id == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getFriendCount(_arg_1:Boolean, _arg_2:Boolean=false):int
        {
            var _local_3:int;
            for each (var _local_4:Friend in _friends)
            {
                if ((((!(_arg_1)) || (_local_4.online)) && ((!(_arg_2)) || (_local_4.followingAllowed))))
                {
                    _local_3 = (_local_3 + 1);
                };
            };
            return (_local_3);
        }

        public function removeFriend(_arg_1:int):Friend
        {
            var _local_2:Friend = getFriend(_arg_1);
            if (_local_2 != null)
            {
                Util.remove(_friends, _local_2);
                return (_local_2);
            };
            return (null);
        }

        private function checkPageIndex():void
        {
            if (this._pageIndex >= this.getPageCount())
            {
                this._pageIndex = Math.max(0, (this.getPageCount() - 1));
            };
        }

        public function getPageCount():int
        {
            return (Math.ceil((this._friends.length / 100)));
        }

        public function getStartFriendIndex():int
        {
            checkPageIndex();
            return (this._pageIndex * 100);
        }

        public function getEndFriendIndex():int
        {
            checkPageIndex();
            return (Math.min(((this._pageIndex + 1) * 100), this._friends.length));
        }

        public function setOpen(_arg_1:Boolean):void
        {
            _open = _arg_1;
            if (!_arg_1)
            {
                for each (var _local_2:Friend in _friends)
                {
                    _local_2.selected = false;
                };
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get received():Boolean
        {
            return (_received);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get friends():Array
        {
            return (_friends);
        }

        public function get view():IWindowContainer
        {
            return (_view);
        }

        public function get open():Boolean
        {
            return (_open);
        }

        public function get pageIndex():int
        {
            return (_pageIndex);
        }

        public function set id(_arg_1:int):void
        {
            _id = _arg_1;
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function set view(_arg_1:IWindowContainer):void
        {
            _view = _arg_1;
        }

        public function set received(_arg_1:Boolean):void
        {
            _received = _arg_1;
        }

        public function set pageIndex(_arg_1:int):void
        {
            _pageIndex = _arg_1;
        }


    }
}