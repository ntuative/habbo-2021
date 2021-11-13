package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.avatar.events.AvatarUpdateEvent;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;

    public class AvatarImageWidget implements ILandingViewWidget 
    {

        private var _landingView:HabboLandingView;
        private var _container:IWidgetWindow;
        private var _SafeStr_2351:UserObjectEvent;
        private var _SafeStr_2352:UserChangeMessageEvent;

        public function AvatarImageWidget(_arg_1:HabboLandingView)
        {
            _landingView = _arg_1;
            _SafeStr_2351 = new UserObjectEvent(onUserObject);
            _SafeStr_2352 = new UserChangeMessageEvent(onUserChange);
            _landingView.communicationManager.addHabboConnectionMessageEvent(_SafeStr_2351);
            _landingView.communicationManager.addHabboConnectionMessageEvent(_SafeStr_2352);
            _landingView.avatarEditor.events.addEventListener("AVATAR_FIGURE_UPDATED", onAvatarFigureUpdated);
        }

        public function get container():IWindow
        {
            return (_container);
        }

        public function dispose():void
        {
            if (_SafeStr_2351 != null)
            {
                _landingView.communicationManager.removeHabboConnectionMessageEvent(_SafeStr_2351);
                _SafeStr_2351 = null;
            };
            if (_SafeStr_2352 != null)
            {
                _landingView.communicationManager.removeHabboConnectionMessageEvent(_SafeStr_2352);
                _SafeStr_2352 = null;
            };
            if (_landingView != null)
            {
                _landingView.avatarEditor.events.removeEventListener("AVATAR_FIGURE_UPDATED", onAvatarFigureUpdated);
                _landingView = null;
            };
            _container = null;
        }

        public function initialize():void
        {
            _container = IWidgetWindow(_landingView.getXmlWindow("avatar_image"));
        }

        public function refresh():void
        {
            refreshAvatarInfo();
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        private function onUserObject(_arg_1:UserObjectEvent):void
        {
            refreshAvatarInfo(_arg_1.getParser().figure);
        }

        private function onUserChange(_arg_1:IMessageEvent):void
        {
            var _local_2:UserChangeMessageEvent = (_arg_1 as UserChangeMessageEvent);
            if (_local_2 == null)
            {
                return;
            };
            if (_local_2.id == -1)
            {
                refreshAvatarInfo(_local_2.figure);
            };
        }

        private function onAvatarFigureUpdated(_arg_1:AvatarUpdateEvent):void
        {
            refreshAvatarInfo(_arg_1.figure);
        }

        private function refreshAvatarInfo(_arg_1:String=null):void
        {
            var _local_2:IAvatarImageWidget;
            if (((!(_arg_1)) && (_landingView.sessionDataManager)))
            {
                _arg_1 = _landingView.sessionDataManager.figure;
            };
            if (_container != null)
            {
                _local_2 = (_container.widget as IAvatarImageWidget);
                if (_local_2 != null)
                {
                    _local_2.figure = _arg_1;
                };
            };
        }


    }
}

