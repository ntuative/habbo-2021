package com.sulake.habbo.toolbar.extensions.settings
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.habbo.communication.messages.outgoing.preferences.SetIgnoreRoomInvitesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.preferences.SetRoomCameraPreferencesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.gifts.ResetPhoneNumberStateMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class OtherSettingsView 
    {

        private var _window:IWindowContainer;
        private var _toolbar:HabboToolbar;

        public function OtherSettingsView(_arg_1:HabboToolbar)
        {
            _toolbar = _arg_1;
            createWindow();
        }

        public function dispose():void
        {
            if (_window == null)
            {
                return;
            };
            _window.dispose();
            _window = null;
        }

        private function createWindow():void
        {
            var _local_5:int;
            var _local_1:IWindow;
            var _local_4:XmlAsset = (_toolbar.assets.getAssetByName("me_menu_other_settings_xml") as XmlAsset);
            _window = (_toolbar.windowManager.buildFromXML((_local_4.content as XML)) as IWindowContainer);
            _local_5 = 0;
            _local_1 = null;
            while (_local_5 < _window.numChildren)
            {
                _local_1 = _window.getChildAt(_local_5);
                _local_1.addEventListener("WME_CLICK", onButtonClicked);
                _local_5++;
            };
            _SafeStr_108(_window.findChildByName("prefer_old_chat_checkbox")).isSelected = _toolbar.freeFlowChat.isDisabledInPreferences;
            _SafeStr_108(_window.findChildByName("ignore_room_invites_checkbox")).isSelected = _toolbar.messenger.getRoomInvitesIgnored();
            var _local_10:Boolean = _toolbar.getBoolean("room.camera.follow_user");
            _window.findChildByName("disable_room_camera_follow_label").visible = _local_10;
            _window.findChildByName("disable_room_camera_follow_checkbox").visible = _local_10;
            if (_toolbar.getBoolean("room.camera.follow_user"))
            {
                _SafeStr_108(_window.findChildByName("disable_room_camera_follow_checkbox")).isSelected = _toolbar.sessionDataManager.isRoomCameraFollowDisabled;
            };
            var _local_2:Boolean = _toolbar.getBoolean("sms.identity.verification.enabled");
            var _local_7:Boolean = (_toolbar.getInteger("phone.verification.status", 0) == 2);
            var _local_3:Boolean = (_toolbar.getInteger("phone.collection.status", 0) == 2);
            var _local_8:Boolean = _toolbar.getBoolean("sms.identity.verification.button.enabled");
            var _local_6:Boolean = (_toolbar.getInteger("phone.collection.status", 0) == 0);
            var _local_9:Boolean = (((_local_2) && (!(_local_7))) && ((_local_3) || ((_local_8) && (_local_6))));
            _window.findChildByName("btn_reset_phone_number_collection").visible = _local_9;
        }

        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_4:Boolean;
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3)
            {
                case "back_btn":
                    dispose();
                    return;
                case "prefer_old_chat_checkbox":
                    _toolbar.freeFlowChat.isDisabledInPreferences = _SafeStr_108(_window.findChildByName("prefer_old_chat_checkbox")).isSelected;
                    if (!_toolbar.freeFlowChat.isDisabledInPreferences)
                    {
                        if (((!(_toolbar.roomUI.chatContainer == null)) && (!(_toolbar.freeFlowChat.displayObject == null))))
                        {
                            _toolbar.roomUI.chatContainer.setDisplayObject(_toolbar.freeFlowChat.displayObject);
                        };
                    }
                    else
                    {
                        _toolbar.freeFlowChat.clear();
                    };
                    return;
                case "ignore_room_invites_checkbox":
                    _toolbar.messenger.setRoomInvitesIgnored(_SafeStr_108(_window.findChildByName("ignore_room_invites_checkbox")).isSelected);
                    _toolbar.connection.send(new SetIgnoreRoomInvitesMessageComposer(_toolbar.messenger.getRoomInvitesIgnored()));
                    return;
                case "disable_room_camera_follow_checkbox":
                    _local_4 = _SafeStr_108(_window.findChildByName("disable_room_camera_follow_checkbox")).isSelected;
                    _toolbar.connection.send(new SetRoomCameraPreferencesMessageComposer(_local_4));
                    _toolbar.sessionDataManager.setRoomCameraFollowDisabled(_local_4);
                    return;
                case "btn_reset_phone_number_collection":
                    _window.findChildByName("btn_reset_phone_number_collection").visible = false;
                    _toolbar.connection.send(new ResetPhoneNumberStateMessageComposer());
                    return;
            };
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }


    }
}

