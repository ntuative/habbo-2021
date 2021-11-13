package com.sulake.habbo.friendlist.domain
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;

    public class FriendRequest implements IDisposable 
    {

        public static const STATE_OPEN:int = 1;
        public static const STATE_ACCEPTED:int = 2;
        public static const STATE_DECLINED:int = 3;
        public static const STATE_FAILED:int = 4;

        private var _requestId:int;
        private var _requesterName:String;
        private var _requesterUserId:int;
        private var _state:int = 1;
        private var _disposed:Boolean;
        private var _view:IWindowContainer;

        public function FriendRequest(_arg_1:FriendRequestData)
        {
            _requestId = _arg_1.requestId;
            _requesterName = _arg_1.requesterName;
            _requesterUserId = _arg_1.requesterUserId;
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            if (view != null)
            {
                view.destroy();
                view = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get requestId():int
        {
            return (_requestId);
        }

        public function get requesterName():String
        {
            return (_requesterName);
        }

        public function get requesterUserId():int
        {
            return (_requesterUserId);
        }

        public function get view():IWindowContainer
        {
            return (_view);
        }

        public function get state():int
        {
            return (_state);
        }

        public function set view(_arg_1:IWindowContainer):void
        {
            _view = _arg_1;
        }

        public function set state(_arg_1:int):void
        {
            _state = _arg_1;
        }


    }
}