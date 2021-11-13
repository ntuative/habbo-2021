package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;

    public class _SafeStr_229 
    {

        public static const CAPTION:String = "caption";
        public static const TITLE:String = "title";
        public static const _SafeStr_2328:String = "subcaption";
        public static const BODYTEXT:String = "bodytext";
        public static const SPACING:String = "spacing";
        public static const CATALOGBUTTON:String = "catalogbutton";
        public static const PROMOTEDROOMBUTTON:String = "promotedroombutton";
        public static const LINK:String = "link";
        public static const _SafeStr_2329:String = "gotoroombutton";
        public static const REQUESTBADGEBUTTON:String = "requestbadgebutton";
        public static const REQUESTBADGEBUTTONSECOND:String = "requestbadgebuttonsecond";
        public static const REQUESTBADGEBUTTONTHIRD:String = "requestbadgebuttonthird";
        public static const REQUESTBADGEBUTTONFOURTH:String = "requestbadgebuttonfourth";
        public static const REQUESTBADGEBUTTONFIFTH:String = "requestbadgebuttonfifth";
        public static const CREDITHABBLETBUTTON:String = "credithabbletbutton";
        public static const COMMUNITYGOALTIMER:String = "communitygoaltimer";
        public static const CUSTOMTIMER:String = "customtimer";
        public static const _SafeStr_2330:String = "gotohomeroombutton";
        public static const _SafeStr_2331:String = "gotocompetitionroombutton";
        public static const REWARDBADGE:String = "rewardbadge";
        public static const IMAGE:String = "image";
        public static const SUBMITCOMPETITIONROOM:String = "submitcompetitionroom";
        public static const CONCURRENTUSERSMETER:String = "concurrentusersmeter";
        public static const CONCURRENTUSERSINFO:String = "concurrentusersinfo";
        public static const DAILYQUEST:String = "dailyquest";
        public static const _SafeStr_2332:String = "buyvipbutton";
        public static const COMMUNITYGOALSCORE:String = "communitygoalscore";
        public static const INTERNAL_LINK_BUTTON:String = "internallinkbutton";


        public static function createHandler(_arg_1:String):IElementHandler
        {
            switch (_arg_1)
            {
                case "caption":
                case "subcaption":
                case "bodytext":
                    return (new TextElementHandler());
                case "title":
                    return (new TitleElementHandler());
                case "spacing":
                    return (new _SafeStr_233());
                case "catalogbutton":
                    return (new CatalogButtonElementHandler());
                case "promotedroombutton":
                    return (new PromotedRoomButtonElementHandler());
                case "link":
                    return (new LinkElementHandler());
                case "gotoroombutton":
                    return (new GoToRoomButtonElementHandler());
                case "requestbadgebutton":
                case "requestbadgebuttonsecond":
                case "requestbadgebuttonthird":
                case "requestbadgebuttonfourth":
                case "requestbadgebuttonfifth":
                    return (new RequestBadgeButtonElementHandler());
                case "credithabbletbutton":
                    return (new _SafeStr_231());
                case "communitygoaltimer":
                    return (new CommunityGoalTimerElementHandler());
                case "customtimer":
                    return (new CustomTimerElementHandler());
                case "gotohomeroombutton":
                    return (new _SafeStr_232());
                case "gotocompetitionroombutton":
                    return (new GoToCompetitionRoomButtonElementHandler());
                case "rewardbadge":
                    return (new _SafeStr_230());
                case "image":
                    return (new _SafeStr_235());
                case "submitcompetitionroom":
                    return (new SubmitCompetitionRoomElementHandler());
                case "concurrentusersmeter":
                    return (new ConcurrentUsersMeterElementHandler());
                case "concurrentusersinfo":
                    return (new ConcurrentUsersInfoElementHandler());
                case "dailyquest":
                    return (new DailyQuestElementHandler());
                case "buyvipbutton":
                    return (new _SafeStr_234());
                case "communitygoalscore":
                    return (new CommunityGoalScoreCounterElementHandler());
                case "internallinkbutton":
                    return (new InternalLinkButtonElementHandler());
            };
            return (null);
        }


    }
}

