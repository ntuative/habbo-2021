package com.sulake.habbo.campaign
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.campaign.calendar.CalendarView;
    import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarData;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDRoomEngine;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarDataMessageEvent;
    import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarDoorOpenedMessageEvent;
    import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarDataMessageParser;
    import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarDoorOpenedMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.campaign.OpenCampaignCalendarDoorComposer;
    import com.sulake.habbo.communication.messages.outgoing.campaign.OpenCampaignCalendarDoorAsStaffComposer;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.room.IGetImageListener;

    public class HabboCampaigns extends Component implements ILinkEventTracker 
    {

        private var _communicationManager:IHabboCommunicationManager;
        private var _localizationManager:IHabboLocalizationManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _windowManager:IHabboWindowManager;
        private var _catalog:IHabboCatalog;
        private var _roomEngine:IRoomEngine;
        private var _SafeStr_1422:CalendarView;
        private var _calendarData:CampaignCalendarData;
        private var _SafeStr_1423:int = -1;
        private var _SafeStr_1424:Boolean = false;

        public function HabboCampaigns(_arg_1:IContext, _arg_2:uint, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communicationManager = _arg_1;
            }, true), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }), new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localizationManager = _arg_1;
            }), new ComponentDependency(new IIDHabboCatalog(), function (_arg_1:IHabboCatalog):void
            {
                _catalog = _arg_1;
            }), new ComponentDependency(new IIDRoomEngine(), function (_arg_1:IRoomEngine):void
            {
                _roomEngine = _arg_1;
            })]));
        }

        override protected function initComponent():void
        {
            _communicationManager.addHabboConnectionMessageEvent(new CampaignCalendarDataMessageEvent(onCampaignCalendarDataMessageEvent));
            _communicationManager.addHabboConnectionMessageEvent(new CampaignCalendarDoorOpenedMessageEvent(onCampaignCalendarDoorOpenedMessageEvent));
            context.addLinkEventTracker(this);
        }

        private function onCampaignCalendarDataMessageEvent(_arg_1:CampaignCalendarDataMessageEvent):void
        {
            var _local_2:CampaignCalendarDataMessageParser = _arg_1.getParser();
            _calendarData = _local_2.cloneData();
        }

        private function onCampaignCalendarDoorOpenedMessageEvent(_arg_1:CampaignCalendarDoorOpenedMessageEvent):void
        {
            var _local_2:CampaignCalendarDoorOpenedMessageParser = _arg_1.getParser();
            if (_local_2.doorOpened)
            {
                showProductNotification(_local_2.productName, _local_2.customImage, _local_2.furnitureClassName);
            };
        }

        public function openPackage(_arg_1:int):void
        {
            _SafeStr_1423 = _arg_1;
            _communicationManager.connection.send(new OpenCampaignCalendarDoorComposer(_calendarData.campaignName, _arg_1));
        }

        public function openPackageAsStaff(_arg_1:int):void
        {
            _SafeStr_1423 = _arg_1;
            _communicationManager.connection.send(new OpenCampaignCalendarDoorAsStaffComposer(_calendarData.campaignName, _arg_1));
        }

        private function showProductNotification(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            var _local_4:IProductData = _sessionDataManager.getProductData(_arg_1);
            if (_local_4 != null)
            {
                _calendarData.openedDays.push(_SafeStr_1423);
                _SafeStr_1423 = -1;
                if (((_arg_2) && (!(_arg_2 == ""))))
                {
                    _SafeStr_1422.setReceivedProduct(_local_4, (getImageGalleryUrl() + _arg_2));
                }
                else
                {
                    if (((_arg_3) && (!(_arg_3 == ""))))
                    {
                        _SafeStr_1422.setReceivedProduct(_local_4);
                        requestIconFromRoomEngine(_SafeStr_1422, _arg_3);
                    };
                };
            };
        }

        private function requestIconFromRoomEngine(_arg_1:IGetImageListener, _arg_2:String):_SafeStr_147
        {
            var _local_3:_SafeStr_147;
            var _local_4:IFurnitureData;
            _local_4 = _sessionDataManager.getFloorItemDataByName(_arg_2);
            if (_local_4)
            {
                _local_3 = _roomEngine.getFurnitureIcon(_local_4.id, _arg_1);
            }
            else
            {
                _local_4 = _sessionDataManager.getWallItemDataByName(_arg_2);
                if (_local_4)
                {
                    _local_3 = _roomEngine.getWallItemIcon(_local_4.id, _arg_1);
                };
            };
            if (((_local_3) && (_local_3.data)))
            {
                _arg_1.imageReady(_local_3.id, _local_3.data);
            };
            return (_local_3);
        }

        public function get linkPattern():String
        {
            return ("openView/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length < 2)
            {
                return;
            };
            if (_local_2[1] == "calendar")
            {
                showCalendar();
            };
        }

        private function showCalendar():void
        {
            if (((!(_SafeStr_1422)) && (_calendarData)))
            {
                _SafeStr_1422 = new CalendarView(this, _windowManager);
            };
        }

        public function hideCalendar():void
        {
            if (_SafeStr_1422)
            {
                _SafeStr_1422.dispose();
                _SafeStr_1422 = null;
            };
        }

        private function getImageGalleryUrl():String
        {
            return (getProperty("image.library.url"));
        }

        public function get calendarData():CampaignCalendarData
        {
            return (_calendarData);
        }

        public function get isAnyRoomController():Boolean
        {
            return (_sessionDataManager.isAnyRoomController);
        }

        public function get localizationManager():IHabboLocalizationManager
        {
            return (_localizationManager);
        }


    }
}

