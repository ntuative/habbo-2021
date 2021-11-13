package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.friendbar.IHabboFriendBar;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorInitData;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.iid.IIDHabboFriendBar;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.configuration.enum.HabboComponentFlags;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;

    public class ModerationManager extends Component implements IHabboModeration 
    {

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _navigator:IHabboNavigator;
        private var _soundManager:IHabboSoundManager;
        private var _tracking:IHabboTracking;
        private var _friendBar:IHabboFriendBar;
        private var _messageHandler:ModerationMessageHandler;
        private var _issueManager:IssueManager;
        private var _startPanel:StartPanelCtrl;
        private var _windowTracker:WindowTracker;
        private var _initMsg:ModeratorInitData;
        private var _currentFlatId:int;

        public function ModerationManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _startPanel = new StartPanelCtrl(this);
            _windowTracker = new WindowTracker();
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }), new ComponentDependency(new IIDHabboNavigator(), function (_arg_1:IHabboNavigator):void
            {
                _navigator = _arg_1;
            }), new ComponentDependency(new IIDHabboSoundManager(), function (_arg_1:IHabboSoundManager):void
            {
                _soundManager = _arg_1;
            }), new ComponentDependency(new IIDHabboTracking(), function (_arg_1:IHabboTracking):void
            {
                _tracking = _arg_1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                IssueCategoryNames.setLocalizationManager(_arg_1);
            }), new ComponentDependency(new IIDHabboFriendBar(), function (_arg_1:IHabboFriendBar):void
            {
                _friendBar = _arg_1;
            })]));
        }

        override protected function initComponent():void
        {
            if (HabboComponentFlags.isRoomViewerMode(flags))
            {
                return;
            };
            _messageHandler = new ModerationMessageHandler(this);
            _issueManager = new IssueManager(this);
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_startPanel != null)
            {
                _startPanel.dispose();
                _startPanel = null;
            };
            super.dispose();
        }

        public function userSelected(_arg_1:int, _arg_2:String):void
        {
            Logger.log(((("USER SELECTED: " + _arg_1) + ", ") + _arg_2));
            this._startPanel.userSelected(_arg_1, _arg_2);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function get issueManager():IssueManager
        {
            return (_issueManager);
        }

        public function get connection():IConnection
        {
            return (_communication.connection);
        }

        public function get startPanel():StartPanelCtrl
        {
            return (_startPanel);
        }

        public function get initMsg():ModeratorInitData
        {
            return (_initMsg);
        }

        public function get messageHandler():ModerationMessageHandler
        {
            return (_messageHandler);
        }

        public function get windowTracker():WindowTracker
        {
            return (_windowTracker);
        }

        public function get currentFlatId():int
        {
            return (_currentFlatId);
        }

        public function get soundManager():IHabboSoundManager
        {
            return (_soundManager);
        }

        public function set initMsg(_arg_1:ModeratorInitData):void
        {
            _initMsg = _arg_1;
        }

        public function set currentFlatId(_arg_1:int):void
        {
            _currentFlatId = _arg_1;
        }

        public function get isModerator():Boolean
        {
            return (_sessionDataManager.hasSecurity(5));
        }

        public function getXmlWindow(_arg_1:String, _arg_2:String="_xml", _arg_3:int=1):IWindow
        {
            var _local_6:IAsset;
            var _local_4:XmlAsset;
            var _local_5:IWindow;
            try
            {
                _local_6 = assets.getAssetByName((_arg_1 + _arg_2));
                _local_4 = XmlAsset(_local_6);
                _local_5 = _windowManager.buildFromXML(XML(_local_4.content), _arg_3);
            }
            catch(e:Error)
            {
            };
            return (_local_5);
        }

        public function openHkPage(_arg_1:String, _arg_2:String):void
        {
            var _local_4:String = getProperty(_arg_1);
            var _local_5:String = (_local_4 + _arg_2);
            var _local_3:String = "housekeeping";
            HabboWebTools.navigateToURL(_local_5, _local_3);
        }

        public function goToRoom(_arg_1:int):void
        {
            _navigator.goToPrivateRoom(_arg_1);
        }

        public function openThread(_arg_1:int, _arg_2:int):void
        {
            context.createLinkEvent(((("groupforum/" + _arg_1) + "/") + _arg_2));
        }

        public function openThreadMessage(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            context.createLinkEvent(((((("groupforum/" + _arg_1) + "/") + _arg_2) + "/") + _arg_3));
        }

        internal function logEvent(_arg_1:String, _arg_2:String):void
        {
            if (_tracking != null)
            {
                _tracking.trackEventLog("Moderation", _arg_2, _arg_1);
            };
        }

        internal function trackGoogle(_arg_1:String, _arg_2:int=-1):void
        {
            if (_tracking != null)
            {
                _tracking.trackGoogle("moderationManager", _arg_1, _arg_2);
            };
        }

        public function set cfhTopics(_arg_1:Vector.<CallForHelpCategoryData>):void
        {
            _issueManager.setCfhTopics(_arg_1);
        }


    }
}

