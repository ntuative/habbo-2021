package com.sulake.habbo.freeflowchat
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.moderation.IHabboModeration;
    import com.sulake.habbo.ui.IRoomUI;
    import com.sulake.habbo.game.IHabboGameManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.freeflowchat.data.ChatEventHandler;
    import com.sulake.habbo.freeflowchat.data.RoomSessionEventHandler;
    import com.sulake.habbo.freeflowchat.history.ChatHistoryBuffer;
    import com.sulake.habbo.freeflowchat.viewer.simulation.ChatFlowStage;
    import com.sulake.habbo.freeflowchat.history.visualization.ChatHistoryScrollView;
    import com.sulake.habbo.freeflowchat.history.visualization.ChatHistoryTray;
    import com.sulake.habbo.freeflowchat.viewer.ChatFlowViewer;
    import com.sulake.habbo.freeflowchat.viewer.ChatBubbleFactory;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomChatSettings;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboModeration;
    import com.sulake.iid.IIDHabboRoomUI;
    import com.sulake.iid.IIDHabboGameManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboWindowManager;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.parser.perk.PerkAllowancesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.RoomChatSettingsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.parser.preferences.AccountPreferencesEvent;
    import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
    import flash.geom.Point;
    import com.sulake.habbo.freeflowchat.data.ChatItem;
    import com.sulake.habbo.configuration.enum.HabboComponentFlags;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.utils.IVector3d;
    import flash.display.DisplayObject;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.ui.IRoomDesktop;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.session.IRoomSession;
    import flash.events.MouseEvent;
    import com.sulake.habbo.freeflowchat.style.IChatStyleLibrary;
    import com.sulake.habbo.communication.messages.outgoing.preferences.SetChatPreferencesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.preferences.SetChatStylePreferenceComposer;

    public class HabboFreeFlowChat extends Component implements IHabboFreeFlowChat
    {

        private var _avatarRenderManager:IAvatarRenderManager;
        private var _roomSessionManager:IRoomSessionManager;
        private var _roomEngine:IRoomEngine;
        private var _navigator:IHabboNavigator;
        private var _moderation:IHabboModeration;
        private var _roomUI:IRoomUI;
        private var _gameManager:IHabboGameManager;
        private var _localizations:IHabboLocalizationManager;
        private var _toolbar:IHabboToolbar;
        private var _communication:IHabboCommunicationManager;
        private var _windowManager:IHabboWindowManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _SafeStr_472:ChatEventHandler;
        private var _SafeStr_473:RoomSessionEventHandler;
        private var _SafeStr_474:ChatHistoryBuffer;
        private var _SafeStr_476:ChatFlowStage;
        private var _chatHistoryScrollView:ChatHistoryScrollView;
        private var _chatHistoryPulldown:ChatHistoryTray;
        private var _chatFlowViewer:ChatFlowViewer;
        private var _SafeStr_477:ChatViewController;
        private var _chatBubbleFactory:ChatBubbleFactory;
        private var _SafeStr_471:Boolean = false;
        private var _isInRoom:Boolean = false;
        private var _roomChatSettings:RoomChatSettings;
        private var _isDisabledInPreferences:Boolean = false;
        private var _preferedChatStyle:int = 1;
        private var _SafeStr_475:Boolean = false;

        public function HabboFreeFlowChat(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public static function getTimeStampNow():String
        {
            var _local_1:Date = new Date();
            var _local_2:Number = _local_1.getHours();
            var _local_4:Number = _local_1.getMinutes();
            var _local_3:Number = _local_1.getSeconds();
            var _local_5:String = ((_local_2 < 10) ? ("0" + _local_2) : _local_2.toString());
            _local_5 = ((_local_5 + ":") + ((_local_4 < 10) ? ("0" + _local_4) : _local_4.toString()));
            _local_5 = ((_local_5 + ":") + ((_local_3 < 10) ? ("0" + _local_3) : _local_3.toString()));
            return (_local_5);
        }

        public static function create9SliceSprite(_arg_1:Rectangle, _arg_2:BitmapData):Sprite
        {
            var _local_8:int;
            var _local_5:Number;
            var _local_9:int;
            var _local_7:Sprite = new Sprite();
            var _local_3:Array = [_arg_1.left, _arg_1.right, _arg_2.width];
            var _local_4:Array = [_arg_1.top, _arg_1.bottom, _arg_2.height];
            _local_7.graphics.clear();
            var _local_6:Number = 0;
            _local_8 = 0;
            while (_local_8 < 3)
            {
                _local_5 = 0;
                _local_9 = 0;
                while (_local_9 < 3)
                {
                    _local_7.graphics.beginBitmapFill(_arg_2);
                    _local_7.graphics.drawRect(_local_6, _local_5, (_local_3[_local_8] - _local_6), (_local_4[_local_9] - _local_5));
                    _local_7.graphics.endFill();
                    _local_5 = _local_4[_local_9];
                    _local_9++;
                };
                _local_6 = _local_3[_local_8];
                _local_8++;
            };
            _local_7.scale9Grid = _arg_1;
            return (_local_7);
        }


        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }, false), new ComponentDependency(new IIDAvatarRenderManager(), function (_arg_1:IAvatarRenderManager):void
            {
                _avatarRenderManager = _arg_1;
            }, false), new ComponentDependency(new IIDHabboRoomSessionManager(), function (_arg_1:IRoomSessionManager):void
            {
                _roomSessionManager = _arg_1;
            }), new ComponentDependency(new IIDRoomEngine(), function (_arg_1:IRoomEngine):void
            {
                _roomEngine = _arg_1;
            }, false), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDHabboNavigator(), function (_arg_1:IHabboNavigator):void
            {
                _navigator = _arg_1;
            }, false), new ComponentDependency(new IIDHabboModeration(), function (_arg_1:IHabboModeration):void
            {
                _moderation = _arg_1;
            }, false), new ComponentDependency(new IIDHabboRoomUI(), function (_arg_1:IRoomUI):void
            {
                _roomUI = _arg_1;
            }, false), new ComponentDependency(new IIDHabboGameManager(), function (_arg_1:IHabboGameManager):void
            {
                _gameManager = _arg_1;
            }, false), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localizations = _arg_1;
            }, false), new ComponentDependency(new IIDHabboToolbar(), function (_arg_1:IHabboToolbar):void
            {
                _toolbar = _arg_1;
            }, false), new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }, false)]));
        }

        override protected function initComponent():void
        {
            _communication.addHabboConnectionMessageEvent(new PerkAllowancesMessageEvent(onPerkAllowances));
            _communication.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(onGuestRoomData));
            _communication.addHabboConnectionMessageEvent(new RoomChatSettingsMessageEvent(onRoomChatSettings));
            _communication.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
            _communication.addHabboConnectionMessageEvent(new AccountPreferencesEvent(onAccountPreferences));
        }

        private function onPerkAllowances(_arg_1:PerkAllowancesMessageEvent):void
        {
            var _local_2:Boolean = _SafeStr_471;
            _SafeStr_471 = true;
            if (((!(_local_2)) && (_SafeStr_471)))
            {
                _chatBubbleFactory = new ChatBubbleFactory(this);
                if (!isDisabledInPreferences)
                {
                    _SafeStr_472 = new ChatEventHandler(this);
                    _SafeStr_473 = new RoomSessionEventHandler(this);
                    _SafeStr_474 = new ChatHistoryBuffer(this);
                };
                if (_isInRoom)
                {
                    roomEntered();
                };
            }
            else
            {
                if (((_local_2) && (!(_SafeStr_471))))
                {
                    if (_chatBubbleFactory)
                    {
                        _chatBubbleFactory.dispose();
                        _chatBubbleFactory = null;
                    };
                    if (_SafeStr_472)
                    {
                        _SafeStr_472.dispose();
                        _SafeStr_472 = null;
                    };
                    if (_SafeStr_473)
                    {
                        _SafeStr_473.dispose();
                        _SafeStr_473 = null;
                    };
                    if (_SafeStr_474)
                    {
                        _SafeStr_474.dispose();
                        _SafeStr_474 = null;
                    };
                    roomLeft();
                };
            };
        }

        private function onGuestRoomData(_arg_1:GetGuestRoomResultEvent):void
        {
            if (((_SafeStr_474) && (!(_SafeStr_475))))
            {
                _SafeStr_474.insertRoomChange(_arg_1.getParser().data);
            };
            _SafeStr_475 = true;
            _roomChatSettings = _arg_1.getParser().chatSettings;
            if (_SafeStr_476)
            {
                _SafeStr_476.refreshSettings();
            };
        }

        private function onRoomEnter(_arg_1:RoomEntryInfoMessageEvent):void
        {
            _SafeStr_475 = false;
            clear();
        }

        private function onRoomChatSettings(_arg_1:RoomChatSettingsMessageEvent):void
        {
            _roomChatSettings = _arg_1.getParser().chatSettings;
            if (((_isInRoom) && (_SafeStr_476)))
            {
                _SafeStr_476.refreshSettings();
            };
        }

        private function onAccountPreferences(_arg_1:AccountPreferencesEvent):void
        {
            _isDisabledInPreferences = _arg_1.getParser().freeFlowChatDisabled;
            _preferedChatStyle = _arg_1.getParser().preferedChatStyle;
        }

        public function getRoomChangeBitmap():BitmapData
        {
            return (BitmapData(assets.getAssetByName("room_change").content));
        }

        public function get roomSessionManager():IRoomSessionManager
        {
            return (_roomSessionManager);
        }

        public function get roomEngine():IRoomEngine
        {
            return (_roomEngine);
        }

        public function get avatarRenderManager():IAvatarRenderManager
        {
            return (_avatarRenderManager);
        }

        public function get gameManager():IHabboGameManager
        {
            return (_gameManager);
        }

        public function get localizations():IHabboLocalizationManager
        {
            return (_localizations);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function roomEntered():void
        {
            _isInRoom = true;
            if (((((_SafeStr_471) && (_chatBubbleFactory)) && (_SafeStr_472)) && (_SafeStr_473)))
            {
                _SafeStr_476 = new ChatFlowStage(this);
                _chatFlowViewer = new ChatFlowViewer(this, _SafeStr_476);
                _chatHistoryScrollView = new ChatHistoryScrollView(this, _SafeStr_474);
                _chatHistoryPulldown = new ChatHistoryTray(this, _chatHistoryScrollView);
                _SafeStr_477 = new ChatViewController(this, _chatFlowViewer, _chatHistoryPulldown);
            };
        }

        public function roomLeft():void
        {
            if (_chatHistoryPulldown)
            {
                _chatHistoryPulldown.dispose();
                _chatHistoryPulldown = null;
            };
            if (_chatHistoryScrollView)
            {
                _chatHistoryScrollView.dispose();
                _chatHistoryPulldown = null;
            };
            if (_chatFlowViewer)
            {
                _chatFlowViewer.dispose();
                _chatFlowViewer = null;
            };
            if (_SafeStr_476)
            {
                _SafeStr_476.dispose();
                _SafeStr_476 = null;
            };
            if (_SafeStr_477)
            {
                _SafeStr_477.dispose();
                _SafeStr_477 = null;
            };
            _isInRoom = false;
        }

        public function insertChat(_arg_1:ChatItem):void
        {
            var _local_2:PooledChatBubble;
            var _local_3:Point;
            if (((((!(_SafeStr_471)) || (!(_SafeStr_474))) || (!(_SafeStr_476))) || (isDisabledInPreferences)))
            {
                return;
            };
            _SafeStr_474.insertChat(_arg_1);
            try
            {
                _local_2 = _chatBubbleFactory.getNewChatBubble(_arg_1);
            }
            catch(e:Error)
            {
                if (e.errorID == 2015)
                {
                    return;
                };
                throw (e);
            };
            _local_3 = _SafeStr_476.insertBubble(_local_2);
            _chatFlowViewer.insertBubble(_local_2, _local_3);
        }

        public function getScreenPointFromRoomLocation(_arg_1:int, _arg_2:IVector3d):Point
        {
            var _local_9:Point;
            var _local_5:Point;
            if ((((_roomEngine == null) || (_chatFlowViewer == null)) || (_chatFlowViewer.rootDisplayObject.stage == null)))
            {
                return (new Point(0, 0));
            };
            var _local_3:int = ((HabboComponentFlags.isRoomViewerMode(flags)) ? 1 : -1);
            var _local_8:IRoomGeometry = roomEngine.getRoomCanvasGeometry(_arg_1, _local_3);
            var _local_7:Number = roomEngine.getRoomCanvasScale(_arg_1);
            var _local_6:Number = ((_chatFlowViewer.rootDisplayObject.stage.stageWidth * _local_7) / 2);
            var _local_4:Number = ((_chatFlowViewer.rootDisplayObject.stage.stageHeight * _local_7) / 2);
            if (((!(_local_8 == null)) && (!(_arg_2 == null))))
            {
                _local_9 = _local_8.getScreenPoint(_arg_2);
                if (_local_9 != null)
                {
                    _local_6 = (_local_6 + (_local_9.x * _local_7));
                    _local_4 = (_local_4 + (_local_9.y * _local_7));
                    _local_5 = roomEngine.getRoomCanvasScreenOffset(_arg_1);
                    if (_local_5 != null)
                    {
                        _local_6 = (_local_6 + _local_5.x);
                        _local_4 = (_local_4 + _local_5.y);
                    };
                };
            };
            return (new Point(_local_6, _local_4));
        }

        public function get chatFlowViewer():ChatFlowViewer
        {
            return (_chatFlowViewer);
        }

        public function get chatBubbleFactory():ChatBubbleFactory
        {
            return (_chatBubbleFactory);
        }

        public function get chatHistoryScrollView():ChatHistoryScrollView
        {
            return (_chatHistoryScrollView);
        }

        public function get displayObject():DisplayObject
        {
            if (_SafeStr_477)
            {
                return (_SafeStr_477.rootDisplayObject);
            };
            return (null);
        }

        public function disableRoomMouseEventsLeftOfX(_arg_1:int):void
        {
            _roomEngine.mouseEventsDisabledLeftToX = _arg_1;
        }

        public function selectAvatarWithChatItem(_arg_1:ChatItem):void
        {
            selectAvatar(_arg_1.roomId, _arg_1.userId);
        }

        public function selectAvatar(_arg_1:int, _arg_2:int):void
        {
            var _local_5:IUserData;
            var _local_4:IUserData;
            if (_roomUI == null)
            {
                return;
            };
            var _local_3:IRoomDesktop = _roomUI.getDesktop("hard_coded_room_id");
            _local_3.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_INFO", _arg_2, 100));
            roomEngine.selectAvatar(_arg_1, _arg_2);
            var _local_6:IRoomSession = _roomSessionManager.getSession(_arg_1);
            if (_local_6)
            {
                _local_5 = _local_6.userDataManager.getUserDataByIndex(_arg_2);
                if (_local_5 != null)
                {
                    _local_4 = _roomSessionManager.getSession(_arg_1).userDataManager.getUserDataByIndex(_arg_2);
                    if (((_local_4) && (_moderation)))
                    {
                        _moderation.userSelected(_local_5.webID, _local_4.name);
                    };
                };
            };
        }

        public function get roomChatSettings():RoomChatSettings
        {
            return (_roomChatSettings);
        }

        public function get roomChatBorderLimited():Boolean
        {
            if (_roomChatSettings)
            {
                return (_roomChatSettings.mode == 1);
            };
            return (false);
        }

        public function clickHasToPropagate(_arg_1:MouseEvent):Boolean
        {
            return ((_roomUI) ? _roomUI.mouseEventPositionHasContextMenu(_arg_1) : false);
        }

        public function get chatStyleLibrary():IChatStyleLibrary
        {
            return ((_chatBubbleFactory) ? _chatBubbleFactory.chatStyleLibrary : null);
        }

        public function get isDisabledInPreferences():Boolean
        {
            return (_isDisabledInPreferences);
        }

        public function set isDisabledInPreferences(_arg_1:Boolean):void
        {
            _isDisabledInPreferences = _arg_1;
            _communication.connection.send(new SetChatPreferencesMessageComposer(_isDisabledInPreferences));
        }

        public function get preferedChatStyle():int
        {
            return (_preferedChatStyle);
        }

        public function set preferedChatStyle(_arg_1:int):void
        {
            _preferedChatStyle = _arg_1;
            _communication.connection.send(new SetChatStylePreferenceComposer(_preferedChatStyle));
        }

        public function clear():void
        {
            if (_SafeStr_476)
            {
                _SafeStr_476.clear();
            };
        }

        public function toggleVisibility():void
        {
            if ((((isDisabledInPreferences) || (!(_SafeStr_471))) || (!(_chatHistoryPulldown))))
            {
                return;
            };
            _chatHistoryPulldown.toggleHistoryVisibility();
        }

        public function get toolbar():IHabboToolbar
        {
            return (_toolbar);
        }


    }
}