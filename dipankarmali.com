import React, { useState, useEffect } from 'react';
import {
  BookOpen,
  GraduationCap,
  MapPin,
  Phone,
  MessageCircle,
  Youtube,
  Send,
  Download,
  CheckCircle2,
  Menu,
  X,
  Globe,
  Award,
  Users,
  Video,
  FileText,
  ShoppingBag,
  Copy,
  Check,
  ExternalLink,
  Sparkles,
  Calendar,
  Clock,
  School,
  Compass,
  Calculator,
  FlaskConical,
  Languages,
  ChevronRight,
  Play,
  Bell,
  ShieldCheck,
  Landmark,
  BookMarked
} from 'lucide-react';

/**
 * Bilingual Content Dictionary (Assamese Default & English)
 * Ensures instant, zero-latency switching across every section of dipankarmali.com
 */
const CONTENT = {
  as: {
    langLabel: 'English',
    switchAria: 'Switch language to English',
    noticeBanner:
      '📢 ২০২৬-২৭ শিক্ষাবৰ্ষৰ বাবে নাৰ্চাৰীৰ পৰা দশম শ্ৰেণীলৈ নামভৰ্তি চলি আছে | SEBA Class 10 সমাজ বিজ্ঞানৰ নতুন আৰ্হি প্ৰশ্নকাকত (Set-1 & Set-2) উপলব্ধ!',
    noticeAction: 'এতিয়াই চাওক',
    nav: {
      about: 'পৰিচয়',
      tuition: 'টিউচন চেণ্টাৰ',
      youtube: 'YouTube (Gyan kendra26)',
      materials: 'অধ্যয়ন সামগ্ৰী',
      contact: 'যোগাযোগ'
    },
    hero: {
      badge: 'SEBA Curriculum Specialist • Assam',
      headline: 'দীপাংকৰ মালী (মালী ছাৰ)',
      subHeadline: 'Dipankar Mali (Mali Sir)',
      qualifications: 'শিক্ষাগত অৰ্হতা: M.A. (Sociology), B.A., D.El.Ed.',
      role1: 'সহকাৰী শিক্ষক, গান্ধীজী জাতীয় বিদ্যালয়, ঝাপুছাবাৰী',
      role2: 'প্ৰতিষ্ঠাপক আৰু সঞ্চালক, জ্ঞান কেন্দ্ৰ টিউচন চেণ্টাৰ, বৰমেৰা',
      introText:
        'অসম মাধ্যমিক শিক্ষা পৰিষদ (SEBA)-ৰ পাঠ্যক্ৰম অনুসৰি নাৰ্চাৰীৰ পৰা দশম শ্ৰেণীলৈ সহজ, সৰল আৰু মানদণ্ডসম্পন্ন অসমীয়া মাধ্যমৰ শিক্ষা প্ৰদানৰ এক বিশ্বস্ত ডিজিটেল মঞ্চ।',
      ctaPrimary: 'SEBA Study Materials চাওক',
      ctaSecondary: 'WhatsApp-ত যোগাযোগ কৰক',
      verifiedLabel: 'অভিজ্ঞ শিক্ষাবিদ আৰু লেখক',
      locationChip: 'বৰমেৰা, আগমনী • ধুবুৰী (অসম)',
      stats: [
        {
          title: 'Nursery – Class 10 (SEBA)',
          subtitle: 'সকলো বিষয়ৰ নিয়মীয়া পাঠদান'
        },
        {
          title: '90-Mark HSLC Model Sets',
          subtitle: 'নতুন আৰ্হি প্ৰশ্নকাকত আৰু সমাধান'
        },
        {
          title: 'Live & Offline Classes',
          subtitle: 'বৰমেৰা চেণ্টাৰ আৰু Teachmint লাইভ'
        },
        {
          title: 'Boromera, Agomani, Dhubri',
          subtitle: 'গ্ৰাম্য ছাত্ৰ-ছাত্ৰীৰ বাবে বিশেষ যত্ন'
        }
      ]
    },
    about: {
      eyebrow: 'মোৰ পৰিচয় • ABOUT EDUCATOR',
      title: 'শিক্ষাৰ পোহৰেৰে গ্ৰাম্য ছাত্ৰ-ছাত্ৰীৰ ভৱিষ্যত গঢ়াৰ এক বিনম্ৰ প্ৰয়াস',
      p1: 'নমস্কাৰ! মই দীপাংকৰ মালী (M.A. in Sociology, B.A., D.El.Ed.)। ধুবুৰী জিলাৰ আগমনী অঞ্চলৰ বৰমেৰা নিবাসী হিচাপে গ্ৰাম্য অঞ্চলৰ ছাত্ৰ-ছাত্ৰীসকলক গুণগত আৰু সহজবোধ্য শিক্ষা প্ৰদান কৰাই মোৰ জীৱনৰ মূল লক্ষ্য।',
      p2: 'বৰ্তমান মই গান্ধীজী জাতীয় বিদ্যালয়, ঝাপুছাবাৰীৰ সহকাৰী শিক্ষক হিচাপে কৰ্মৰত হোৱাৰ লগতে বৰমেৰা স্থিত "জ্ঞান কেন্দ্ৰ টিউচন চেণ্টাৰ (Gyan Kendra Tuition Center)"-ৰ প্ৰতিষ্ঠাপক আৰু সঞ্চালক হিচাপে নাৰ্চাৰীৰ পৰা দশম শ্ৰেণীলৈ ছাত্ৰ-ছাত্ৰীসকলক নিৰন্তৰ মাৰ্গদৰ্শন আগবঢ়াই আহিছোঁ।',
      p3: 'দশম শ্ৰেণীৰ (HSLC) পৰীক্ষাৰ্থীসকলৰ সুবিধাৰ বাবে মই অসমীয়া মাধ্যমৰ সমাজ বিজ্ঞানৰ সম্পূৰ্ণ গাইডবুক আৰু ৯০ নম্বৰৰ আৰ্হি প্ৰশ্নকাকত প্ৰস্তুত কৰিছোঁ। লগতে Teachmint-ৰ জৰিয়তে লাইভ PDF এনোটেচন ক্লাছ আৰু YouTube চেনেল "Gyan kendra26"-ৰ মাধ্যমেৰে বিনামূলীয়া ভিডিঅ’ পাঠদান আগবঢ়াইছোঁ।',
      pillars: [
        {
          title: 'বিদ্যালয়ৰ পাঠদান অভিজ্ঞতা',
          desc: 'গান্ধীজী জাতীয় বিদ্যালয়, ঝাপুছাবাৰীত সহকাৰী শিক্ষক হিচাপে শ্ৰেণীকোঠাৰ বাস্তৱ অভিজ্ঞতা।'
        },
        {
          title: 'HSLC বিশেষজ্ঞ মাৰ্গদৰ্শন',
          desc: 'SEBA দশম শ্ৰেণীৰ মেট্ৰিক পৰীক্ষাৰ বাবে অধ্যায়ভিত্তিক নোটছ আৰু মেপ পইণ্টিং প্ৰশিক্ষণ।'
        },
        {
          title: 'ডিজিটেল আৰু স্মাৰ্ট শিক্ষা',
          desc: 'Teachmint লাইভ ক্লাছ আৰু Gyan kendra26 YouTube চেনেলৰ জৰিয়তে আধুনিক শিক্ষা।'
        }
      ]
    },
    tuition: {
      eyebrow: 'জ্ঞান কেন্দ্ৰ টিউচন চেণ্টাৰ • ADMISSIONS 2026–27',
      title: 'জ্ঞান কেন্দ্ৰ টিউচন চেণ্টাৰ (Gyan Kendra Tuition Center)',
      addressLabel: 'ঠিকনা:',
      addressValue:
        'গাঁও: বৰমেৰা, ডাকঘৰ আৰু থানা: আগমনী, জিলা: ধুবুৰী, অসম, পিন: ৭৮৩৩৩৫',
      classesBadge: 'শ্ৰেণীসমূহ: নাৰ্চাৰীৰ পৰা দশম শ্ৰেণীলৈ (SEBA Board)',
      subjectsTitle: 'পাঠদান কৰা বিষয়সমূহ (Subjects Covered)',
      subjects: [
        {
          name: 'সমাজ বিজ্ঞান (Social Science)',
          detail: 'ইতিহাস, ভূগোল, ৰাজনীতি আৰু অৰ্থনীতি বিজ্ঞান'
        },
        {
          name: 'গণিত (Mathematics)',
          detail: 'সহজ সূত্ৰ আৰু নিয়মীয়া অনুশীলনী সমাধান'
        },
        {
          name: 'উচ্চ গণিত (Advanced Mathematics)',
          detail: 'নৱম আৰু দশম শ্ৰেণীৰ বিশেষ পাঠদান'
        },
        {
          name: 'সাধাৰণ বিজ্ঞান (General Science)',
          detail: 'পদাৰ্থ, ৰসায়ন আৰু জীৱ বিজ্ঞানৰ স্পষ্ট ধাৰণা'
        },
        {
          name: 'ইংৰাজী (English)',
          detail: 'Grammar, Writing Skills আৰু পাঠ্যপুথি বিশ্লেষণ'
        },
        {
          name: 'অসমীয়া (Assamese)',
          detail: 'সাহিত্য, ব্যাকৰণ আৰু ৰচনা লিখন কৌশল'
        },
        {
          name: 'সংস্কৃত (Sanskrit)',
          detail: 'মৌলিক ব্যাকৰণ আৰু পাঠভিত্তিক প্ৰশ্নোত্তৰ'
        }
      ],
      featuresTitle: 'আমাৰ শিক্ষাদানৰ বিশেষ বৈশিষ্ট্যসমূহ',
      features: [
        'বৰমেৰা চেণ্টাৰত অফলাইন শ্ৰেণীকোঠাৰ সু-ব্যৱস্থা (Offline Classroom Batches)',
        'Teachmint এপৰ জৰিয়তে লাইভ অনলাইন ক্লাছ আৰু PDF এনোটেচন সুবিধা',
        'প্ৰতিটো অধ্যায়ৰ শেষত নিয়মীয়া সাপ্তাহিক পৰীক্ষা (Regular Chapter Tests)',
        'HSLC পৰীক্ষাৰ প্ৰস্তুতিমূলক বিশেষ আলোচনা চক্ৰ আৰু অসম মেপ পইণ্টিং কৰ্মশালা'
      ],
      formTitle: 'নামভৰ্তিৰ বাবে আগতীয়া অনুসন্ধান (Admission Inquiry)',
      formSubtitle:
        'তলৰ তথ্যখিনি পূৰণ কৰি পোনপটীয়াকৈ মালী ছাৰৰ WhatsApp-লৈ বাৰ্তা প্ৰেৰণ কৰক:',
      studentNameLabel: 'ছাত্ৰ বা ছাত্ৰীৰ নাম *',
      studentNamePlaceholder: 'যেনে: ৰাহুল দাস',
      classLabel: 'শ্ৰেণী বাছনি কৰক *',
      modeLabel: 'বিষয় / পাঠদানৰ মাধ্যম *',
      modes: [
        'সকলো বিষয় (All Subjects - অফলাইন বৰমেৰা)',
        'সমাজ বিজ্ঞান আৰু গণিত (HSLC Special Batch)',
        'অনলাইন লাইভ ক্লাছ (Teachmint Online Batch)',
        'কেৱল সমাজ বিজ্ঞান (Class 9 & 10 SEBA)'
      ],
      submitBtn: 'WhatsApp-ত নামভৰ্তিৰ বাৰ্তা পঠিয়াওক',
      nameError: 'অনুগ্ৰহ কৰি ছাত্ৰ বা ছাত্ৰীৰ নাম লিখক।'
    },
    youtube: {
      eyebrow: 'OFFICIAL YOUTUBE CHANNEL • ডিজিটেল শ্ৰেণীকোঠা',
      title: 'Gyan kendra26 — সহজ অসমীয়াত SEBA পাঠদান',
      subtitle:
        'ঘৰতে বহি বিনামূলীয়াকৈ দশম শ্ৰেণীৰ সমাজ বিজ্ঞান, মডেল প্ৰশ্নকাকতৰ সমাধান আৰু পৰীক্ষাৰ গুৰুত্বপূৰ্ণ টিপছ শিকিবলৈ আজি আমাৰ YouTube চেনেলটো Subscribe কৰক।',
      categories: [
        'SEBA Class 10 সমাজ বিজ্ঞানৰ অধ্যায়ভিত্তিক আলোচনা',
        'HSLC 2026-27 আৰ্হি প্ৰশ্নকাকতৰ সম্পূৰ্ণ সমাধান',
        'অসম আৰু ভাৰতৰ মেপ পইণ্টিং (Map Pointing) গাইড',
        'কম সময়ত বেছি নম্বৰ পোৱাৰ পৰীক্ষাৰ কৌশল (Exam Tips)'
      ],
      featuredHeading: 'জনপ্ৰিয় ভিডিঅ’ পাঠসমূহ (ক্লিক কৰি বিষয়বস্তু চাওক)',
      videos: [
        {
          id: 'v1',
          tag: 'ইতিহাস • অধ্যায় ১',
          duration: '২৪:১৫',
          title: 'বংগ বিভাজন (১৯০৫) আৰু স্বদেশী আন্দোলন — সম্পূৰ্ণ অধ্যায় বিশ্লেষণ',
          summary:
            'লৰ্ড কাৰ্জনৰ বংগ বিভাজনৰ কাৰণ, স্বদেশী আন্দোলনৰ ফলাফল আৰু HSLC পৰীক্ষাত আহিবলগীয়া অতি গুৰুত্বপূৰ্ণ চমু আৰু দীঘল প্ৰশ্নৰ সহজ আলোচনা।',
          topics: ['বংগ বিভাজনৰ পটভূমি', 'স্বদেশী আৰু বৰ্জন আন্দোলন', 'অসমত ইয়াৰ প্ৰভাৱ', 'SEBA সম্ভাৱ্য প্ৰশ্নোত্তৰ']
        },
        {
          id: 'v2',
          tag: 'HSLC 2026–27 মডেল পেপাৰ',
          duration: '৩৮:৪০',
          title: 'SEBA নতুন ৯০ নম্বৰৰ আৰ্হি প্ৰশ্নকাকত (45 MCQs + 45 Descriptive) সমাধান',
          summary:
            'নতুন SEBA পৰীক্ষা পদ্ধতি অনুসৰি ৪৫টা MCQ, Assertion-Reason প্ৰশ্ন আৰু ৪৫ নম্বৰৰ বৰ্ণনামূলক উত্তৰ কেনেকৈ সঠিকভাৱে লিখিব তাৰ সম্পূৰ্ণ গাইড।',
          topics: ['OMR / MCQ কৌশল', 'Assertion-Reason সমাধান', 'সময় ব্যৱস্থাপনা', 'উত্তৰ লিখাৰ সঠিক নিয়ম']
        },
        {
          id: 'v3',
          tag: 'ভূগোল • Map Pointing',
          duration: '১৮:২০',
          title: 'অসমৰ ভূগোল আৰু মেপ পইণ্টিং (Assam Map Pointing) — নিশ্চিত ৪ নম্বৰ',
          summary:
            'অসমৰ ৰাষ্ট্ৰীয় উদ্যান, অভয়াৰণ্য, তেল শোধনাগাৰ, নদ-নদী আৰু ঐতিহাসিক স্থানসমূহ মানচিত্ৰত নিখুঁতভাৱে দেখুওৱাৰ সহজ কৌশল।',
          topics: ['ৰাষ্ট্ৰীয় উদ্যান আৰু অভয়াৰণ্য', 'তেল শোধনাগাৰ আৰু উদ্যোগ', 'প্ৰধান নদ-নদী আৰু দলং', 'পূৰ্বৰ বৰ্ষৰ মেপ প্ৰশ্ন']
        }
      ],
      btnYoutube: 'YouTube চেনেল চাওক (@Gyankendra26)',
      btnTelegram: 'Telegram চেনেলত যোগ দিয়ক (@gyankendra26)',
      btnWhatsappChannel: 'Official WhatsApp চেনেলত যোগ দিয়ক'
    },
    materials: {
      eyebrow: 'SEBA CLASS 10 STUDY MATERIALS • অসমীয়া মাধ্যম',
      title: 'দশম শ্ৰেণীৰ অধ্যয়ন সামগ্ৰী, গাইডবুক আৰু বিনামূলীয়া PDF',
      subtitle:
        'SEBA-ৰ নতুন পাঠ্যক্ৰম অনুসৰি প্ৰস্তুত কৰা নিৰ্ভৰযোগ্য প্ৰশ্নোত্তৰ, MCQ অনুশীলনী আৰু HSLC আৰ্হি প্ৰশ্নকাকতসমূহ তলৰ পৰা ডাউনলোড বা অৰ্ডাৰ কৰক।',
      tabs: {
        all: 'সকলো (All)',
        free: 'বিনামূলীয়া PDF (Free Notes)',
        paid: 'গাইডবুক আৰু মডেল পেপাৰ (Guidebook & Model Sets)'
      },
      freeBadge: 'বিনামূলীয়া PDF',
      premiumBadge: 'SEBA HSLC বিশেষ সংস্কৰণ',
      downloadBtn: 'বিনামূলীয়া PDF ডাউনলোড কৰক',
      orderBtn: 'Order / Buy Now (অৰ্ডাৰ কৰক)',
      inquireSetBtn: 'Set-1 & Set-2 অৰ্ডাৰ / তথ্য লওক',
      items: [
        {
          id: 'guidebook-199',
          category: 'paid',
          badge: '৩৩% ৰেহাই • বেষ্টচেলাৰ',
          title: 'SEBA Class 10 Social Science Complete Guidebook (Assamese Medium)',
          description:
            'ইতিহাস, ভূগোল, ৰাজনীতি আৰু অৰ্থনীতি বিজ্ঞানৰ সম্পূৰ্ণ অধ্যায়ভিত্তিক প্ৰশ্নোত্তৰ, গুৰুত্বপূৰ্ণ MCQ, Assertion-Reason আৰু HSLC পৰীক্ষাৰ বিশেষ নোটছ।',
          price: '₹199',
          mrp: '₹299',
          discount: '33% OFF',
          highlights: ['সম্পূৰ্ণ ৪টা খণ্ড অন্তৰ্ভুক্ত', 'সহজ অসমীয়া ভাষাত উত্তৰ', 'PDF / প্ৰিণ্ট সংস্কৰণ উপলব্ধ'],
          actionType: 'order_guide'
        },
        {
          id: 'model-sets-2027',
          category: 'paid',
          badge: '৯০ নম্বৰৰ SEBA আৰ্হি',
          title: 'HSLC 2026–2027 Social Science Model Question Papers (Set-1 & Set-2)',
          description:
            'নতুন ৯০ নম্বৰৰ SEBA পৰীক্ষা পদ্ধতি (45 MCQs + 45 Descriptive Marks) অনুসৰি প্ৰস্তুত কৰা দুটা পূৰ্ণাংগ আৰ্হি প্ৰশ্নকাকত, সম্পূৰ্ণ উত্তৰ বহী (Answer Keys) আৰু অসম মেপ পইণ্টিং গাইড।',
          price: 'Set-1 & Set-2',
          mrp: '',
          discount: 'Answer Keys সহ',
          highlights: ['45 MCQs + 45 Descriptive Marks', 'সম্পূৰ্ণ উত্তৰ বহী (Answer Key)', 'অসম মেপ পইণ্টিং গাইড'],
          actionType: 'order_sets'
        },
        {
          id: 'hist-ch1-exercise',
          category: 'free',
          badge: 'ইতিহাস • অধ্যায় ১',
          title: 'ইতিহাস অধ্যায় ১: বংগ বিভাজন আৰু স্বদেশী আন্দোলন — পাঠভিত্তিক প্ৰশ্নোত্তৰ (Exercise Solutions)',
          description:
            'পাঠ্যপুথিৰ অনুশীলনীৰ সকলো অতি চমু, চমু আৰু দীঘল প্ৰশ্নৰ নিখুঁত আৰু সহজ অসমীয়া উত্তৰৰ PDF।',
          url: 'https://drive.google.com/file/d/1XvJLjAat8zJci6tSgCv27EtMl__WeQCx/view?usp=sharing',
          actionType: 'free_pdf'
        },
        {
          id: 'hist-ch1-additional',
          category: 'free',
          badge: 'ইতিহাস • অধ্যায় ১',
          title: 'ইতিহাস অধ্যায় ১: অতিৰিক্ত গুৰুত্বপূৰ্ণ প্ৰশ্নোত্তৰ (Additional Q&A)',
          description:
            'HSLC পৰীক্ষাত পাঠ্যপুথিৰ ভিতৰৰ পৰা আহিবলগীয়া অতিৰিক্ত গুৰুত্বপূৰ্ণ প্ৰশ্ন আৰু উত্তৰৰ সংকলন।',
          url: 'https://drive.google.com/file/d/1aGwkdKWLwlfRtPumKnaQKat6jN6s-Rhj/view?usp=sharing',
          actionType: 'free_pdf'
        },
        {
          id: 'hist-ch1-mcq',
          category: 'free',
          badge: 'MCQ আৰু Assertion-Reason',
          title: 'ইতিহাস অধ্যায় ১: Assertion-Reason আৰু MCQ অনুশীলনী',
          description:
            'নতুন SEBA OMR পদ্ধতি অনুসৰি ৪৫ নম্বৰৰ বস্তুনিষ্ঠ প্ৰশ্নৰ বাবে বিশেষভাৱে প্ৰস্তুত কৰা MCQ আৰু বিবৃতি-কাৰণ অনুশীলনী।',
          url: 'https://drive.google.com/file/d/1Vp4o3fuSas7IConKn52sluYzagM5LoXa/view?usp=sharing',
          actionType: 'free_pdf'
        },
        {
          id: 'hslc-2027-mock',
          category: 'free',
          badge: 'HSLC 2027 Mock Test',
          title: 'HSLC 2027 Social Science Mock Test Paper (PDF)',
          description:
            'ছাত্ৰ-ছাত্ৰীয়ে ঘৰতে বহি নিজৰ প্ৰস্তুতি পৰীক্ষা কৰিব পৰাকৈ SEBA আৰ্হিৰ পূৰ্ণাংগ মক টেষ্ট প্ৰশ্নকাকত।',
          url: 'https://drive.google.com/file/d/1615W-SZsrhx4vkz6R7TibUGg0EWBhhxT/view?usp=sharing',
          actionType: 'free_pdf'
        }
      ]
    },
    modal: {
      titleGuide: 'SEBA Class 10 Social Science Guidebook অৰ্ডাৰ কৰক',
      titleSets: 'HSLC 2026–2027 Model Papers (Set-1 & Set-2) সংগ্ৰহ কৰক',
      subtitle:
        'তলত দিয়া UPI ID-ত পেমেণ্ট কৰি বা পোনপটীয়াকৈ WhatsApp-ত বাৰ্তা পঠিয়াই আপোনাৰ অধ্যয়ন সামগ্ৰী নিশ্চিত কৰক।',
      upiLabel: 'Official UPI ID (GPay / PhonePe / Paytm):',
      copyBtn: 'কপি কৰক',
      copiedBtn: 'কপি হ’ল!',
      stepsTitle: 'অৰ্ডাৰ কৰাৰ সহজ নিয়ম:',
      steps: [
        'ওপৰৰ UPI ID (7896723247@upi)-ত ₹199 (বা নিৰ্ধাৰিত মাচুল) পেমেণ্ট কৰক।',
        'পেমেণ্টৰ স্ক্ৰীণশ্বট (Screenshot) লওক।',
        'তলৰ বুটামত ক্লিক কৰি WhatsApp-ত স্ক্ৰীণশ্বট আৰু আপোনাৰ নাম পঠিয়াওক—লগে লগে PDF কপি লাভ কৰিব।'
      ],
      whatsappConfirmBtn: 'WhatsApp-ত অৰ্ডাৰ নিশ্চিত কৰক (+91 7896723247)',
      closeBtn: 'বন্ধ কৰক'
    },
    contact: {
      eyebrow: 'যোগাযোগ • CONTACT & LOCATION',
      title: 'যিকোনো শৈক্ষিক সহায় বা নামভৰ্তিৰ বাবে যোগাযোগ কৰক',
      subtitle:
        'টিউচন চেণ্টাৰত নামভৰ্তি, অনলাইন ক্লাছ বা HSLC অধ্যয়ন সামগ্ৰীৰ বাবে তলৰ ঠিকনা আৰু মাধ্যমসমূহৰ জৰিয়তে যোগাযোগ কৰিব পাৰে।',
      addressHeading: 'চেণ্টাৰৰ ঠিকনা (Address)',
      fullAddress:
        'Vill: Boromera, P.O. & P.S.: Agomani, Dist: Dhubri, Assam, PIN: 783335',
      assameseAddress:
        'গাঁও: বৰমেৰা, ডাকঘৰ আৰু থানা: আগমনী, জিলা: ধুবুৰী, অসম, পিন: ৭৮৩৩৩৫',
      directCallHeading: 'পোনপটীয়া ফোন আৰু WhatsApp',
      quickLinksHeading: 'অফিচিয়েল ডিজিটেল প্লেটফৰ্মসমূহ',
      copyright:
        '© 2026 Dipankar Mali (Mali Sir) | dipankarmali.com. All Rights Reserved.'
    }
  },
  en: {
    langLabel: 'অসমীয়া',
    switchAria: 'ভাষা অসমীয়ালৈ সলনি কৰক',
    noticeBanner:
      '📢 Admissions open for 2026–27 academic session from Nursery to Class 10 | New SEBA Class 10 Social Science Model Question Papers (Set-1 & Set-2) now available!',
    noticeAction: 'View Now',
    nav: {
      about: 'About',
      tuition: 'Tuition',
      youtube: 'YouTube (Gyan kendra26)',
      materials: 'Study Materials',
      contact: 'Contact'
    },
    hero: {
      badge: 'SEBA Curriculum Specialist • Assam',
      headline: 'Dipankar Mali (Mali Sir)',
      subHeadline: 'দীপাংকৰ মালী (মালী ছাৰ)',
      qualifications: 'Qualifications: M.A. (Sociology), B.A., D.El.Ed.',
      role1: 'Assistant Teacher, Gandhiji Jatiya Bidyalaya, Jhapusabari',
      role2: 'Founder & Director, Gyan Kendra Tuition Center, Boromera',
      introText:
        'A trusted academic and digital learning portal dedicated to guiding students from Nursery to Class 10 under the SEBA (Board of Secondary Education, Assam) curriculum with clarity and care.',
      ctaPrimary: 'Explore SEBA Study Materials',
      ctaSecondary: 'Contact on WhatsApp',
      verifiedLabel: 'Experienced Educator & Author',
      locationChip: 'Boromera, Agomani • Dhubri, Assam',
      stats: [
        {
          title: 'Nursery – Class 10 (SEBA)',
          subtitle: 'Comprehensive All-Subject Coaching'
        },
        {
          title: '90-Mark HSLC Model Sets',
          subtitle: 'Latest Pattern Papers & Answer Keys'
        },
        {
          title: 'Live & Offline Classes',
          subtitle: 'Boromera Center & Teachmint Live'
        },
        {
          title: 'Boromera, Agomani, Dhubri',
          subtitle: 'Dedicated Rural Student Mentorship'
        }
      ]
    },
    about: {
      eyebrow: 'ABOUT EDUCATOR • মোৰ পৰিচয়',
      title: 'Empowering Rural Students Across Dhubri Through Structured, Accessible Education',
      p1: 'Welcome! I am Dipankar Mali (M.A. in Sociology, B.A., D.El.Ed.). Based in Boromera, Agomani in Dhubri district of Assam (PIN 783335), my core mission is to make quality, concept-driven education accessible to every student in rural and semi-urban Assam.',
      p2: 'Alongside serving as an Assistant Teacher at Gandhiji Jatiya Bidyalaya, Jhapusabari, I lead Gyan Kendra Tuition Center in Boromera as Founder & Director—mentoring learners from Nursery to Class 10 across foundational and board examination subjects.',
      p3: 'To support HSLC (Class 10) board candidates across Assam, I have authored comprehensive Assamese-medium Social Science guidebooks and 90-mark model question papers, complemented by interactive Teachmint live PDF-annotation classes and free video lectures on YouTube (Gyan kendra26).',
      pillars: [
        {
          title: 'Classroom Teaching Excellence',
          desc: 'Dedicated day-to-day school teaching experience as Assistant Teacher at Gandhiji Jatiya Bidyalaya, Jhapusabari.'
        },
        {
          title: 'HSLC Board Exam Mentorship',
          desc: 'Structured SEBA Class 10 preparation with chapter-wise guides, MCQs, and Assam map pointing workshops.'
        },
        {
          title: 'Interactive Digital Pedagogy',
          desc: 'Combining live Teachmint PDF annotation classes with free Assamese video lessons on Gyan kendra26.'
        }
      ]
    },
    tuition: {
      eyebrow: 'GYAN KENDRA TUITION CENTER • ADMISSIONS 2026–27',
      title: 'Gyan Kendra Tuition Center (জ্ঞান কেন্দ্ৰ টিউচন চেণ্টাৰ)',
      addressLabel: 'Location:',
      addressValue:
        'Village Boromera, P.O. & P.S. Agomani, Dist. Dhubri, Assam, PIN 783335',
      classesBadge: 'Classes Covered: Nursery to Class 10 (SEBA Board)',
      subjectsTitle: 'Subjects Covered',
      subjects: [
        {
          name: 'Social Science',
          detail: 'History, Geography, Political Science & Economics'
        },
        {
          name: 'Mathematics',
          detail: 'Step-by-step problem solving & concept clarity'
        },
        {
          name: 'Advanced Mathematics',
          detail: 'Specialized coaching for Class 9 & Class 10'
        },
        {
          name: 'General Science',
          detail: 'Clear foundational lessons in Physics, Chemistry & Biology'
        },
        {
          name: 'English',
          detail: 'Grammar, composition, writing skills & textbook analysis'
        },
        {
          name: 'Assamese',
          detail: 'Literature, grammar & structured answer writing'
        },
        {
          name: 'Sanskrit',
          detail: 'Foundational grammar & chapter-wise question answers'
        }
      ],
      featuresTitle: 'Key Teaching Features',
      features: [
        'Structured offline classroom batches in Boromera with personal attention',
        'Live online classes with interactive PDF annotation via Teachmint',
        'Regular chapter-wise tests and continuous performance evaluation',
        'Focused HSLC exam preparation seminars and Assam map pointing sessions'
      ],
      formTitle: 'Quick Admission Inquiry',
      formSubtitle:
        'Fill in the student details below to send an instant admission inquiry directly to Mali Sir on WhatsApp:',
      studentNameLabel: 'Student Name *',
      studentNamePlaceholder: 'e.g., Rahul Das',
      classLabel: 'Select Class *',
      modeLabel: 'Subject / Learning Mode *',
      modes: [
        'All Subjects (Offline Batch - Boromera)',
        'Social Science & Mathematics (HSLC Special Batch)',
        'Live Online Class (Teachmint Batch)',
        'Social Science Only (Class 9 & 10 SEBA)'
      ],
      submitBtn: 'Send Admission Inquiry via WhatsApp',
      nameError: 'Please enter the student name before sending.'
    },
    youtube: {
      eyebrow: 'OFFICIAL YOUTUBE CHANNEL • DIGITAL CLASSROOM',
      title: 'Gyan kendra26 — SEBA Lessons in Simple Assamese',
      subtitle:
        'Learn Class 10 Social Science chapter explanations, HSLC 2026–27 model paper solutions, and Assam map pointing techniques for free from anywhere in Assam.',
      categories: [
        'SEBA Class 10 Social Science Chapter-wise Explanations',
        'HSLC 2026–27 Model Question Paper Solutions',
        'Assam Map Pointing Guides & Visual Tricks',
        'Exam Strategy & High-Scoring Tips in Simple Assamese'
      ],
      featuredHeading: 'Featured Video Lessons (Click any card to preview syllabus)',
      videos: [
        {
          id: 'v1',
          tag: 'History • Chapter 1',
          duration: '24:15',
          title: 'Partition of Bengal (1905) & Swadeshi Movement — Full Chapter Explanation',
          summary:
            'Detailed explanation of Lord Curzon’s Partition of Bengal, consequences of the Swadeshi Movement, and key short & descriptive questions for SEBA HSLC.',
          topics: ['Background of Bengal Partition', 'Swadeshi & Boycott Movement', 'Impact on Assam', 'Expected HSLC Q&A']
        },
        {
          id: 'v2',
          tag: 'HSLC 2026–27 Model Paper',
          duration: '38:40',
          title: 'SEBA 90-Mark New Pattern Paper (45 MCQs + 45 Descriptive) Complete Solution',
          summary:
            'Step-by-step walkthrough of the new 90-mark SEBA blueprint covering 45 objective MCQs, Assertion-Reason items, and structured descriptive answers.',
          topics: ['OMR / MCQ Strategy', 'Assertion-Reason Logic', 'Exam Time Management', 'Answer Presentation']
        },
        {
          id: 'v3',
          tag: 'Geography • Map Pointing',
          duration: '18:20',
          title: 'Geography of Assam & Map Pointing Guide — Guaranteed Board Marks',
          summary:
            'Easy visual techniques to accurately locate National Parks, Wildlife Sanctuaries, Oil Refineries, Rivers, and Historic Sites on the map of Assam.',
          topics: ['National Parks & Sanctuaries', 'Refineries & Industries', 'Major Rivers & Bridges', 'Previous Year Map Questions']
        }
      ],
      btnYoutube: 'Visit YouTube (@Gyankendra26)',
      btnTelegram: 'Join Telegram (@gyankendra26)',
      btnWhatsappChannel: 'Join Official WhatsApp Channel'
    },
    materials: {
      eyebrow: 'SEBA CLASS 10 STUDY MATERIALS • ASSAMESE MEDIUM',
      title: 'Class 10 Study Materials, Complete Guidebook & Free PDFs',
      subtitle:
        'Access free chapter-wise PDF notes, MCQ practice sheets, mock test papers, and complete SEBA HSLC Social Science guides prepared by Mali Sir.',
      tabs: {
        all: 'All (সকলো)',
        free: 'Free Notes (বিনামূলীয়া PDF)',
        paid: 'Guidebook & Model Sets'
      },
      freeBadge: 'Free PDF Download',
      premiumBadge: 'SEBA HSLC Special Edition',
      downloadBtn: 'Download Free PDF',
      orderBtn: 'Order / Buy Now',
      inquireSetBtn: 'Order / Get Set-1 & Set-2',
      items: [
        {
          id: 'guidebook-199',
          category: 'paid',
          badge: '33% OFF • Bestseller',
          title: 'SEBA Class 10 Social Science Complete Guidebook (Assamese Medium)',
          description:
            'Complete chapter-wise solutions across History, Geography, Political Science & Economics, along with high-yield MCQs, Assertion-Reason sets, and exam notes.',
          price: '₹199',
          mrp: '₹299',
          discount: '33% OFF',
          highlights: ['All 4 Social Science Sections', 'Clear Assamese Medium Answers', 'Instant Digital / Print Support'],
          actionType: 'order_guide'
        },
        {
          id: 'model-sets-2027',
          category: 'paid',
          badge: '90-Mark SEBA Pattern',
          title: 'HSLC 2026–2027 Social Science Model Question Papers (Set-1 & Set-2)',
          description:
            'Two full-length 90-Mark SEBA Pattern question papers (45 MCQs + 45 Descriptive Marks) complete with detailed Answer Keys & Assam Map Pointing guide.',
          price: 'Set-1 & Set-2',
          mrp: '',
          discount: 'With Answer Keys',
          highlights: ['45 MCQs + 45 Descriptive Marks', 'Complete Answer Keys Included', 'Assam Map Pointing Guide'],
          actionType: 'order_sets'
        },
        {
          id: 'hist-ch1-exercise',
          category: 'free',
          badge: 'History • Chapter 1',
          title: 'ইতিহাস অধ্যায় ১: বংগ বিভাজন আৰু স্বদেশী আন্দোলন — পাঠভিত্তিক প্ৰশ্নোত্তৰ (Exercise Solutions)',
          description:
            'Complete, exam-ready Assamese solutions for all textbook exercise questions from History Chapter 1 (Partition of Bengal & Swadeshi Movement).',
          url: 'https://drive.google.com/file/d/1XvJLjAat8zJci6tSgCv27EtMl__WeQCx/view?usp=sharing',
          actionType: 'free_pdf'
        },
        {
          id: 'hist-ch1-additional',
          category: 'free',
          badge: 'History • Chapter 1',
          title: 'ইতিহাস অধ্যায় ১: অতিৰিক্ত গুৰুত্বপূৰ্ণ প্ৰশ্নোত্তৰ (Additional Q&A)',
          description:
            'Curated in-text and extra important questions & answers frequently asked in SEBA Class 10 examinations.',
          url: 'https://drive.google.com/file/d/1aGwkdKWLwlfRtPumKnaQKat6jN6s-Rhj/view?usp=sharing',
          actionType: 'free_pdf'
        },
        {
          id: 'hist-ch1-mcq',
          category: 'free',
          badge: 'MCQ & Assertion-Reason',
          title: 'ইতিহাস অধ্যায় ১: Assertion-Reason আৰু MCQ অনুশীলনী',
          description:
            'Objective MCQ and Assertion-Reason practice worksheet tailored for the 45-mark SEBA OMR pattern.',
          url: 'https://drive.google.com/file/d/1Vp4o3fuSas7IConKn52sluYzagM5LoXa/view?usp=sharing',
          actionType: 'free_pdf'
        },
        {
          id: 'hslc-2027-mock',
          category: 'free',
          badge: 'HSLC 2027 Mock Test',
          title: 'HSLC 2027 Social Science Mock Test Paper (PDF)',
          description:
            'Full-length self-assessment mock test paper modeled on the latest SEBA Class 10 board examination blueprint.',
          url: 'https://drive.google.com/file/d/1615W-SZsrhx4vkz6R7TibUGg0EWBhhxT/view?usp=sharing',
          actionType: 'free_pdf'
        }
      ]
    },
    modal: {
      titleGuide: 'Order SEBA Class 10 Social Science Guidebook (₹199)',
      titleSets: 'Get HSLC 2026–2027 Model Question Papers (Set-1 & Set-2)',
      subtitle:
        'Complete your payment using the official UPI ID below and confirm instantly via WhatsApp to receive your study material.',
      upiLabel: 'Official UPI ID (GPay / PhonePe / Paytm):',
      copyBtn: 'Copy UPI ID',
      copiedBtn: 'Copied!',
      stepsTitle: 'How to Order in 3 Easy Steps:',
      steps: [
        'Pay ₹199 (or applicable fee) to UPI ID: 7896723247@upi via GPay, PhonePe, or Paytm.',
        'Take a screenshot of your successful payment confirmation.',
        'Click the button below to share your payment screenshot & name on WhatsApp for instant delivery.'
      ],
      whatsappConfirmBtn: 'Confirm Order on WhatsApp (+91 7896723247)',
      closeBtn: 'Close'
    },
    contact: {
      eyebrow: 'CONTACT & LOCATION • যোগাযোগ',
      title: 'Get in Touch for Admissions & Study Materials',
      subtitle:
        'Reach out directly for Nursery–Class 10 tuition admissions at Boromera, Teachmint live online batches, or SEBA Class 10 study resources.',
      addressHeading: 'Center Address',
      fullAddress:
        'Vill: Boromera, P.O. & P.S.: Agomani, Dist: Dhubri, Assam, PIN: 783335',
      assameseAddress:
        'গাঁও: বৰমেৰা, ডাকঘৰ আৰু থানা: আগমনী, জিলা: ধুবুৰী, অসম, পিন: ৭৮৩৩৩৫',
      directCallHeading: 'Direct Phone & WhatsApp',
      quickLinksHeading: 'Official Digital Channels',
      copyright:
        '© 2026 Dipankar Mali (Mali Sir) | dipankarmali.com. All Rights Reserved.'
    }
  }
};

const CLASS_OPTIONS = [
  'Nursery / LKG / UKG',
  'Class 1',
  'Class 2',
  'Class 3',
  'Class 4',
  'Class 5',
  'Class 6',
  'Class 7',
  'Class 8',
  'Class 9 (SEBA)',
  'Class 10 (HSLC SEBA)'
];

export default function App() {
  // Language state: defaults to Assamese ('as')
  const [lang, setLang] = useState('as');
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  // Study Materials filter state: 'all' | 'free' | 'paid'
  const [materialFilter, setMaterialFilter] = useState('all');

  // Interactive Order / UPI Modal state
  const [orderModalItem, setOrderModalItem] = useState(null);
  const [upiCopied, setUpiCopied] = useState(false);

  // Interactive YouTube Video Topic Preview state
  const [selectedVideo, setSelectedVideo] = useState(null);

  // Admission Inquiry Form state
  const [studentName, setStudentName] = useState('');
  const [studentClass, setStudentClass] = useState('Class 10 (HSLC SEBA)');
  const [studyMode, setStudyMode] = useState(0);
  const [formError, setFormError] = useState('');

  const t = CONTENT[lang];

  // Dynamically load Google Fonts ('Noto Sans Bengali', 'Plus Jakarta Sans', 'Inter')
  useEffect(() => {
    const fontLinkId = 'dipankar-mali-google-fonts';
    if (!document.getElementById(fontLinkId)) {
      const link = document.createElement('link');
      link.id = fontLinkId;
      link.rel = 'stylesheet';
      link.href =
        'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Noto+Sans+Bengali:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap';
      document.head.appendChild(link);
    }
  }, []);

  // Toggle between Assamese and English
  const toggleLanguage = () => {
    setLang((prev) => (prev === 'as' ? 'en' : 'as'));
  };

  // Smooth section navigation
  const scrollToSection = (id) => {
    setMobileMenuOpen(false);
    const element = document.getElementById(id);
    if (element) {
      element.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
  };

  // Copy UPI ID helper with graceful fallback
  const handleCopyUpi = async () => {
    const upiId = '7896723247@upi';
    try {
      if (navigator.clipboard && navigator.clipboard.writeText) {
        await navigator.clipboard.writeText(upiId);
      } else {
        const textArea = document.createElement('textarea');
        textArea.value = upiId;
        document.body.appendChild(textArea);
        textArea.select();
        document.execCommand('copy');
        document.body.removeChild(textArea);
      }
      setUpiCopied(true);
      setTimeout(() => setUpiCopied(false), 2500);
    } catch {
      setUpiCopied(true);
      setTimeout(() => setUpiCopied(false), 2500);
    }
  };

  // Handle WhatsApp Admission Inquiry submission
  const handleAdmissionSubmit = (e) => {
    e.preventDefault();
    if (!studentName.trim()) {
      setFormError(t.tuition.nameError);
      return;
    }
    setFormError('');
    const selectedModeLabel = t.tuition.modes[studyMode] || t.tuition.modes[0];
    const message =
      lang === 'as'
        ? `নমস্কাৰ মালী ছাৰ,\nমই জ্ঞান কেন্দ্ৰ টিউচন চেণ্টাৰত নামভৰ্তিৰ বাবে তথ্য জানিব বিচাৰোঁ:\n• ছাত্ৰ/ছাত্ৰীৰ নাম: ${studentName.trim()}\n• শ্ৰেণী: ${studentClass}\n• বিষয়/মাধ্যম: ${selectedModeLabel}\n(dipankarmali.com-ৰ পৰা প্ৰেৰিত)`
        : `Hello Mali Sir,\nI would like to inquire about admission at Gyan Kendra Tuition Center:\n• Student Name: ${studentName.trim()}\n• Class: ${studentClass}\n• Subject/Mode: ${selectedModeLabel}\n(Sent via dipankarmali.com)`;

    const whatsappUrl = `https://wa.me/917896723247?text=${encodeURIComponent(message)}`;
    window.open(whatsappUrl, '_blank', 'noopener,noreferrer');
  };

  // Filter study materials based on selected category tab
  const filteredMaterials = t.materials.items.filter((item) => {
    if (materialFilter === 'all') return true;
    return item.category === materialFilter;
  });

  // Subject icon mapper for Tuition Center grid
  const getSubjectIcon = (idx) => {
    const icons = [
      <Landmark className="w-5 h-5 text-amber-600" />,
      <Calculator className="w-5 h-5 text-indigo-600" />,
      <Compass className="w-5 h-5 text-sky-600" />,
      <FlaskConical className="w-5 h-5 text-emerald-600" />,
      <BookOpen className="w-5 h-5 text-amber-700" />,
      <Languages className="w-5 h-5 text-rose-600" />,
      <BookMarked className="w-5 h-5 text-purple-600" />
    ];
    return icons[idx % icons.length];
  };

  return (
    <div
      style={{
        fontFamily:
          "'Noto Sans Bengali', 'Plus Jakarta Sans', 'Inter', system-ui, -apple-system, sans-serif"
      }}
      className="min-h-screen bg-slate-50 text-slate-900 antialiased selection:bg-amber-200 selection:text-slate-900"
    >
      {/* 1. TOP RUNNING NOTICE BANNER (জাননী) */}
      <div className="bg-slate-950 text-amber-300 border-b border-amber-500/30">
        <div className="max-w-7xl mx-auto px-4 py-2.5 flex flex-col sm:flex-row items-center justify-between gap-2 text-xs sm:text-sm">
          <div className="flex items-center gap-2 text-center sm:text-left font-medium leading-snug">
            <span className="inline-flex h-2 w-2 rounded-full bg-amber-400 animate-pulse shrink-0" />
            <span className="text-amber-100">{t.noticeBanner}</span>
          </div>
          <button
            onClick={() => scrollToSection('study-materials')}
            className="shrink-0 inline-flex items-center gap-1 bg-amber-500 hover:bg-amber-400 text-slate-950 font-bold px-3 py-1 rounded-full text-xs transition-colors cursor-pointer"
          >
            {t.noticeAction}
            <ChevronRight className="w-3.5 h-3.5" />
          </button>
        </div>
      </div>

      {/* 2. STICKY RESPONSIVE HEADER / NAVBAR */}
      <header className="sticky top-0 z-40 bg-white/95 backdrop-blur-md border-b border-slate-200/90 shadow-xs">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16 md:h-20">
            {/* Brand Identity */}
            <a
              href="#top"
              onClick={(e) => {
                e.preventDefault();
                window.scrollTo({ top: 0, behavior: 'smooth' });
              }}
              className="flex items-center gap-3 group"
            >
              <div className="w-10 h-10 md:w-11 md:h-11 rounded-xl bg-gradient-to-br from-slate-900 via-indigo-950 to-slate-800 border border-amber-400/50 flex items-center justify-center text-amber-400 font-extrabold text-lg shadow-sm group-hover:scale-105 transition-transform">
                DM
              </div>
              <div>
                <div className="font-extrabold text-slate-900 text-base md:text-lg tracking-tight leading-none">
                  DipankarMali<span className="text-amber-600">.com</span>
                </div>
                <div className="text-[11px] md:text-xs font-medium text-slate-500 mt-1">
                  Gyan Kendra • Boromera
                </div>
              </div>
            </a>

            {/* Desktop Navigation Links */}
            <nav className="hidden lg:flex items-center gap-6">
              <button
                onClick={() => scrollToSection('about')}
                className="text-sm font-semibold text-slate-700 hover:text-amber-600 transition-colors cursor-pointer"
              >
                {t.nav.about}
              </button>
              <button
                onClick={() => scrollToSection('tuition')}
                className="text-sm font-semibold text-slate-700 hover:text-amber-600 transition-colors cursor-pointer"
              >
                {t.nav.tuition}
              </button>
              <button
                onClick={() => scrollToSection('youtube')}
                className="text-sm font-semibold text-slate-700 hover:text-rose-600 transition-colors cursor-pointer flex items-center gap-1.5"
              >
                <span className="w-2 h-2 rounded-full bg-rose-600" />
                {t.nav.youtube}
              </button>
              <button
                onClick={() => scrollToSection('study-materials')}
                className="text-sm font-semibold text-slate-700 hover:text-amber-600 transition-colors cursor-pointer"
              >
                {t.nav.materials}
              </button>
              <button
                onClick={() => scrollToSection('contact')}
                className="text-sm font-semibold text-slate-700 hover:text-amber-600 transition-colors cursor-pointer"
              >
                {t.nav.contact}
              </button>
            </nav>

            {/* Right Controls: Language Toggle & Mobile Menu Button */}
            <div className="flex items-center gap-2 sm:gap-3">
              <button
                onClick={toggleLanguage}
                aria-label={t.switchAria}
                className="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-full border border-slate-300 bg-slate-100 hover:bg-amber-50 hover:border-amber-400 text-slate-900 font-bold text-xs sm:text-sm transition-all shadow-2xs cursor-pointer"
              >
                <Globe className="w-4 h-4 text-amber-600" />
                <span>{t.langLabel}</span>
              </button>

              <button
                onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
                aria-label="Toggle Menu"
                className="lg:hidden p-2.5 rounded-xl border border-slate-200 text-slate-700 hover:bg-slate-100 transition-colors cursor-pointer"
              >
                {mobileMenuOpen ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
              </button>
            </div>
          </div>
        </div>

        {/* Mobile Dropdown Navigation */}
        {mobileMenuOpen && (
          <div className="lg:hidden bg-white border-t border-slate-200 px-4 pt-3 pb-5 space-y-1.5 shadow-lg">
            <button
              onClick={() => scrollToSection('about')}
              className="block w-full text-left px-3.5 py-2.5 rounded-xl text-sm font-semibold text-slate-800 hover:bg-slate-100"
            >
              {t.nav.about}
            </button>
            <button
              onClick={() => scrollToSection('tuition')}
              className="block w-full text-left px-3.5 py-2.5 rounded-xl text-sm font-semibold text-slate-800 hover:bg-slate-100"
            >
              {t.nav.tuition}
            </button>
            <button
              onClick={() => scrollToSection('youtube')}
              className="block w-full text-left px-3.5 py-2.5 rounded-xl text-sm font-semibold text-rose-700 hover:bg-rose-50"
            >
              {t.nav.youtube}
            </button>
            <button
              onClick={() => scrollToSection('study-materials')}
              className="block w-full text-left px-3.5 py-2.5 rounded-xl text-sm font-semibold text-slate-800 hover:bg-slate-100"
            >
              {t.nav.materials}
            </button>
            <button
              onClick={() => scrollToSection('contact')}
              className="block w-full text-left px-3.5 py-2.5 rounded-xl text-sm font-semibold text-slate-800 hover:bg-slate-100"
            >
              {t.nav.contact}
            </button>
          </div>
        )}
      </header>

      {/* 3. HERO SECTION */}
      <section
        id="top"
        className="relative overflow-hidden bg-gradient-to-b from-slate-900 via-slate-900 to-indigo-950 text-white pt-12 pb-16 md:pt-20 md:pb-24"
      >
        {/* Subtle decorative academic grid background */}
        <div
          className="absolute inset-0 opacity-10 pointer-events-none"
          style={{
            backgroundImage:
              'radial-gradient(circle at 1px 1px, rgba(245, 158, 11, 0.65) 1px, transparent 0)',
            backgroundSize: '28px 28px'
          }}
        />

        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-10 lg:gap-12 items-center">
            {/* Left Column: Educator Identity, Credentials & CTAs */}
            <div className="lg:col-span-7 space-y-6">
              <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-amber-500/15 border border-amber-400/40 text-amber-300 text-xs sm:text-sm font-semibold">
                <Award className="w-4 h-4 text-amber-400 shrink-0" />
                <span>{t.hero.badge}</span>
              </div>

              <div>
                <h1 className="text-3xl sm:text-4xl md:text-5xl font-extrabold tracking-tight text-white leading-tight">
                  {t.hero.headline}
                </h1>
                <p className="text-lg sm:text-xl font-semibold text-amber-400 mt-1.5">
                  {t.hero.subHeadline}
                </p>
              </div>

              {/* Qualifications & Institutional Roles Card */}
              <div className="bg-white/5 backdrop-blur-xs border border-white/15 rounded-2xl p-4 sm:p-5 space-y-3">
                <div className="flex items-start gap-3">
                  <GraduationCap className="w-5 h-5 text-amber-400 shrink-0 mt-0.5" />
                  <p className="text-sm sm:text-base font-bold text-amber-200">
                    {t.hero.qualifications}
                  </p>
                </div>
                <div className="flex items-start gap-3">
                  <School className="w-5 h-5 text-sky-400 shrink-0 mt-0.5" />
                  <p className="text-sm sm:text-base text-slate-200">
                    {t.hero.role1}
                  </p>
                </div>
                <div className="flex items-start gap-3">
                  <BookOpen className="w-5 h-5 text-emerald-400 shrink-0 mt-0.5" />
                  <p className="text-sm sm:text-base text-slate-200">
                    {t.hero.role2}
                  </p>
                </div>
              </div>

              <p className="text-slate-300 text-sm sm:text-base leading-relaxed max-w-2xl">
                {t.hero.introText}
              </p>

              {/* Primary CTA Buttons */}
              <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3.5 pt-1">
                <button
                  onClick={() => scrollToSection('study-materials')}
                  className="inline-flex items-center justify-center gap-2 bg-amber-500 hover:bg-amber-400 text-slate-950 font-extrabold px-6 py-3.5 rounded-xl text-sm sm:text-base shadow-lg shadow-amber-500/20 transition-all cursor-pointer"
                >
                  <FileText className="w-5 h-5" />
                  <span>{t.hero.ctaPrimary}</span>
                </button>

                <a
                  href="https://wa.me/917896723247"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center justify-center gap-2 bg-emerald-600 hover:bg-emerald-500 text-white font-bold px-6 py-3.5 rounded-xl text-sm sm:text-base shadow-lg shadow-emerald-600/20 transition-all"
                >
                  <MessageCircle className="w-5 h-5" />
                  <span>{t.hero.ctaSecondary}</span>
                </a>
              </div>
            </div>

            {/* Right Column: Educator Profile & Quick Stats Card */}
            <div className="lg:col-span-5">
              <div className="bg-slate-800/80 backdrop-blur-md border border-slate-700/80 rounded-3xl p-6 sm:p-7 shadow-2xl">
                {/* Top Crest & Verified Educator Header */}
                <div className="flex items-center gap-4 pb-6 border-b border-slate-700/80">
                  <div className="w-16 h-16 sm:w-20 sm:h-20 rounded-2xl bg-gradient-to-br from-amber-400 via-amber-500 to-amber-600 text-slate-950 flex flex-col items-center justify-center font-extrabold shadow-lg shrink-0">
                    <span className="text-2xl sm:text-3xl leading-none">DM</span>
                    <span className="text-[10px] uppercase tracking-wider mt-1 font-bold">
                      Mali Sir
                    </span>
                  </div>
                  <div>
                    <div className="inline-flex items-center gap-1.5 text-xs font-semibold text-emerald-400 bg-emerald-500/10 border border-emerald-500/30 px-2.5 py-0.5 rounded-full mb-1.5">
                      <ShieldCheck className="w-3.5 h-3.5" />
                      <span>{t.hero.verifiedLabel}</span>
                    </div>
                    <h2 className="text-lg sm:text-xl font-bold text-white">
                      Dipankar Mali
                    </h2>
                    <p className="text-xs sm:text-sm text-slate-300 flex items-center gap-1 mt-0.5">
                      <MapPin className="w-3.5 h-3.5 text-amber-400 shrink-0" />
                      <span>{t.hero.locationChip}</span>
                    </p>
                  </div>
                </div>

                {/* 4 Quick Stats Grid */}
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5 pt-6">
                  {t.hero.stats.map((stat, idx) => (
                    <div
                      key={idx}
                      className="bg-slate-900/80 border border-slate-700/70 rounded-2xl p-4 hover:border-amber-400/50 transition-colors"
                    >
                      <div className="text-amber-400 font-extrabold text-sm sm:text-base leading-snug">
                        {stat.title}
                      </div>
                      <div className="text-slate-300 text-xs mt-1 leading-relaxed">
                        {stat.subtitle}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* 4. ABOUT SECTION (মোৰ পৰিচয়) */}
      <section id="about" className="py-16 md:py-24 bg-white border-b border-slate-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-3xl">
            <span className="text-xs sm:text-sm font-extrabold uppercase tracking-wider text-amber-600">
              {t.about.eyebrow}
            </span>
            <h2 className="text-2xl sm:text-3xl md:text-4xl font-extrabold text-slate-900 mt-2 leading-tight">
              {t.about.title}
            </h2>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-12 mt-8 items-start">
            {/* Detailed Bio Paragraphs */}
            <div className="lg:col-span-7 space-y-4 text-slate-700 text-base sm:text-lg leading-relaxed">
              <p>{t.about.p1}</p>
              <p>{t.about.p2}</p>
              <p>{t.about.p3}</p>
            </div>

            {/* 3 Core Academic Pillars */}
            <div className="lg:col-span-5 space-y-4">
              {t.about.pillars.map((pillar, index) => (
                <div
                  key={index}
                  className="bg-amber-50/60 border border-amber-200/80 rounded-2xl p-5 flex items-start gap-4"
                >
                  <div className="w-10 h-10 rounded-xl bg-slate-900 text-amber-400 font-extrabold flex items-center justify-center shrink-0">
                    0{index + 1}
                  </div>
                  <div>
                    <h3 className="font-bold text-slate-900 text-base sm:text-lg">
                      {pillar.title}
                    </h3>
                    <p className="text-slate-600 text-sm mt-1 leading-relaxed">
                      {pillar.desc}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* 5. GYAN KENDRA TUITION CENTER SECTION (জ্ঞান কেন্দ্ৰ টিউচন চেণ্টাৰ) */}
      <section id="tuition" className="py-16 md:py-24 bg-slate-50 border-b border-slate-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          {/* Header & Location Banner */}
          <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-6 pb-10 border-b border-slate-200">
            <div className="space-y-2.5 max-w-3xl">
              <span className="text-xs sm:text-sm font-extrabold uppercase tracking-wider text-amber-600">
                {t.tuition.eyebrow}
              </span>
              <h2 className="text-2xl sm:text-3xl md:text-4xl font-extrabold text-slate-900">
                {t.tuition.title}
              </h2>
              <div className="flex items-start gap-2 text-slate-700 text-sm sm:text-base pt-1">
                <MapPin className="w-5 h-5 text-amber-600 shrink-0 mt-0.5" />
                <span>
                  <strong className="text-slate-900">{t.tuition.addressLabel}</strong>{' '}
                  {t.tuition.addressValue}
                </span>
              </div>
            </div>

            <div className="inline-flex items-center gap-2 bg-slate-900 text-amber-300 px-4 py-2.5 rounded-xl text-xs sm:text-sm font-bold self-start lg:self-auto shadow-xs">
              <GraduationCap className="w-4 h-4 text-amber-400 shrink-0" />
              <span>{t.tuition.classesBadge}</span>
            </div>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-10 mt-10">
            {/* Left 7 Cols: Subjects Grid & Teaching Features */}
            <div className="lg:col-span-7 space-y-8">
              <div>
                <h3 className="text-lg sm:text-xl font-extrabold text-slate-900 mb-4">
                  {t.tuition.subjectsTitle}
                </h3>
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
                  {t.tuition.subjects.map((subj, idx) => (
                    <div
                      key={idx}
                      className="bg-white border border-slate-200 rounded-2xl p-4 flex items-start gap-3.5 shadow-2xs hover:border-amber-400 transition-colors"
                    >
                      <div className="w-10 h-10 rounded-xl bg-slate-100 flex items-center justify-center shrink-0">
                        {getSubjectIcon(idx)}
                      </div>
                      <div>
                        <div className="font-bold text-slate-900 text-sm sm:text-base">
                          {subj.name}
                        </div>
                        <div className="text-xs sm:text-sm text-slate-600 mt-0.5">
                          {subj.detail}
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>

              {/* Key Teaching Features */}
              <div className="bg-white border border-slate-200 rounded-2xl p-6 shadow-2xs">
                <h3 className="text-lg font-extrabold text-slate-900 mb-4 flex items-center gap-2">
                  <Sparkles className="w-5 h-5 text-amber-500" />
                  <span>{t.tuition.featuresTitle}</span>
                </h3>
                <ul className="space-y-3">
                  {t.tuition.features.map((feat, idx) => (
                    <li key={idx} className="flex items-start gap-3 text-sm sm:text-base text-slate-700">
                      <CheckCircle2 className="w-5 h-5 text-emerald-600 shrink-0 mt-0.5" />
                      <span>{feat}</span>
                    </li>
                  ))}
                </ul>
              </div>
            </div>

            {/* Right 5 Cols: Interactive WhatsApp Admission Inquiry Card */}
            <div className="lg:col-span-5">
              <div className="bg-white border-2 border-slate-900 rounded-3xl p-6 sm:p-7 shadow-xl sticky top-24">
                <div className="inline-flex items-center gap-1.5 bg-amber-100 text-amber-900 text-xs font-extrabold px-3 py-1 rounded-full mb-3">
                  <Calendar className="w-3.5 h-3.5" />
                  <span>2026–2027 Session</span>
                </div>
                <h3 className="text-xl sm:text-2xl font-extrabold text-slate-900">
                  {t.tuition.formTitle}
                </h3>
                <p className="text-sm text-slate-600 mt-1.5 leading-relaxed">
                  {t.tuition.formSubtitle}
                </p>

                <form onSubmit={handleAdmissionSubmit} className="mt-5 space-y-4">
                  <div>
                    <label
                      htmlFor="student-name"
                      className="block text-sm font-bold text-slate-800 mb-1.5"
                    >
                      {t.tuition.studentNameLabel}
                    </label>
                    <input
                      id="student-name"
                      type="text"
                      value={studentName}
                      onChange={(e) => {
                        setStudentName(e.target.value);
                        if (formError) setFormError('');
                      }}
                      placeholder={t.tuition.studentNamePlaceholder}
                      className="w-full px-4 py-3 rounded-xl border border-slate-300 bg-slate-50 focus:bg-white focus:outline-none focus:ring-2 focus:ring-amber-500 focus:border-amber-500 text-sm sm:text-base"
                    />
                    {formError && (
                      <p className="text-rose-600 text-xs font-semibold mt-1.5">
                        {formError}
                      </p>
                    )}
                  </div>

                  <div>
                    <label
                      htmlFor="student-class"
                      className="block text-sm font-bold text-slate-800 mb-1.5"
                    >
                      {t.tuition.classLabel}
                    </label>
                    <select
                      id="student-class"
                      value={studentClass}
                      onChange={(e) => setStudentClass(e.target.value)}
                      className="w-full px-4 py-3 rounded-xl border border-slate-300 bg-slate-50 focus:bg-white focus:outline-none focus:ring-2 focus:ring-amber-500 focus:border-amber-500 text-sm sm:text-base"
                    >
                      {CLASS_OPTIONS.map((cls) => (
                        <option key={cls} value={cls}>
                          {cls}
                        </option>
                      ))}
                    </select>
                  </div>

                  <div>
                    <label
                      htmlFor="study-mode"
                      className="block text-sm font-bold text-slate-800 mb-1.5"
                    >
                      {t.tuition.modeLabel}
                    </label>
                    <select
                      id="study-mode"
                      value={studyMode}
                      onChange={(e) => setStudyMode(Number(e.target.value))}
                      className="w-full px-4 py-3 rounded-xl border border-slate-300 bg-slate-50 focus:bg-white focus:outline-none focus:ring-2 focus:ring-amber-500 focus:border-amber-500 text-sm sm:text-base"
                    >
                      {t.tuition.modes.map((mode, idx) => (
                        <option key={idx} value={idx}>
                          {mode}
                        </option>
                      ))}
                    </select>
                  </div>

                  <button
                    type="submit"
                    className="w-full inline-flex items-center justify-center gap-2 bg-emerald-600 hover:bg-emerald-500 text-white font-extrabold px-5 py-3.5 rounded-xl text-sm sm:text-base shadow-md transition-all cursor-pointer"
                  >
                    <MessageCircle className="w-5 h-5" />
                    <span>{t.tuition.submitBtn}</span>
                  </button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* 6. YOUTUBE CHANNEL SHOWCASE (`Gyan kendra26`) */}
      <section
        id="youtube"
        className="py-16 md:py-24 bg-gradient-to-br from-slate-950 via-slate-900 to-rose-950/90 text-white"
      >
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-6">
            <div className="max-w-3xl space-y-3">
              <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-rose-600/20 border border-rose-500/40 text-rose-300 text-xs sm:text-sm font-bold">
                <Youtube className="w-4 h-4 text-rose-500" />
                <span>{t.youtube.eyebrow}</span>
              </div>
              <h2 className="text-2xl sm:text-3xl md:text-4xl font-extrabold text-white">
                {t.youtube.title}
              </h2>
              <p className="text-slate-300 text-sm sm:text-base leading-relaxed">
                {t.youtube.subtitle}
              </p>
            </div>

            {/* Channel CTA Buttons */}
            <div className="flex flex-wrap gap-3">
              <a
                href="https://www.youtube.com/@Gyankendra26"
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-2 bg-rose-600 hover:bg-rose-500 text-white font-extrabold px-5 py-3 rounded-xl text-sm shadow-lg shadow-rose-600/25 transition-all"
              >
                <Youtube className="w-5 h-5" />
                <span>{t.youtube.btnYoutube}</span>
              </a>
              <a
                href="https://t.me/gyankendra26"
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-2 bg-sky-600 hover:bg-sky-500 text-white font-bold px-5 py-3 rounded-xl text-sm transition-all"
              >
                <Send className="w-4 h-4" />
                <span>{t.youtube.btnTelegram}</span>
              </a>
              <a
                href="https://whatsapp.com/channel/0029Vb7YYlADZ4LZOtGek320"
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-2 bg-emerald-600 hover:bg-emerald-500 text-white font-bold px-5 py-3 rounded-xl text-sm transition-all"
              >
                <Bell className="w-4 h-4" />
                <span>{t.youtube.btnWhatsappChannel}</span>
              </a>
            </div>
          </div>

          {/* 4 Core Video Categories */}
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mt-10">
            {t.youtube.categories.map((cat, idx) => (
              <div
                key={idx}
                className="bg-white/5 border border-white/10 rounded-2xl p-4 flex items-start gap-3"
              >
                <div className="w-8 h-8 rounded-lg bg-rose-500/20 text-rose-400 flex items-center justify-center shrink-0 mt-0.5">
                  <Video className="w-4 h-4" />
                </div>
                <p className="text-sm font-semibold text-slate-100 leading-snug">
                  {cat}
                </p>
              </div>
            ))}
          </div>

          {/* Interactive Featured Video Lesson Cards */}
          <div className="mt-12">
            <h3 className="text-base sm:text-lg font-bold text-amber-300 mb-5 flex items-center gap-2">
              <Play className="w-4 h-4 fill-amber-300" />
              <span>{t.youtube.featuredHeading}</span>
            </h3>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              {t.youtube.videos.map((video) => {
                const isSelected = selectedVideo?.id === video.id;
                return (
                  <div
                    key={video.id}
                    onClick={() => setSelectedVideo(isSelected ? null : video)}
                    role="button"
                    tabIndex={0}
                    onKeyDown={(e) => {
                      if (e.key === 'Enter' || e.key === ' ') {
                        e.preventDefault();
                        setSelectedVideo(isSelected ? null : video);
                      }
                    }}
                    className={`group rounded-2xl overflow-hidden border transition-all cursor-pointer flex flex-col justify-between ${
                      isSelected
                        ? 'bg-slate-800 border-amber-400 ring-2 ring-amber-400/40'
                        : 'bg-slate-900/90 border-slate-700/80 hover:border-rose-500/70'
                    }`}
                  >
                    <div>
                      {/* Simulated Video Thumbnail Frame */}
                      <div className="relative h-40 bg-gradient-to-br from-slate-800 via-indigo-950 to-rose-950 p-5 flex flex-col justify-between border-b border-slate-700/70">
                        <div className="flex items-center justify-between">
                          <span className="text-xs font-bold bg-rose-600 text-white px-2.5 py-1 rounded-md">
                            {video.tag}
                          </span>
                          <span className="text-xs font-mono bg-black/60 text-slate-200 px-2 py-0.5 rounded">
                            {video.duration}
                          </span>
                        </div>

                        <div className="flex items-center justify-between">
                          <span className="text-xs font-bold text-amber-300">
                            Gyan kendra26 • Mali Sir
                          </span>
                          <div className="w-10 h-10 rounded-full bg-rose-600 group-hover:scale-110 text-white flex items-center justify-center shadow-lg transition-transform">
                            <Play className="w-4 h-4 fill-white ml-0.5" />
                          </div>
                        </div>
                      </div>

                      {/* Card Text Content */}
                      <div className="p-5">
                        <h4 className="font-bold text-white text-base leading-snug group-hover:text-amber-300 transition-colors">
                          {video.title}
                        </h4>
                        <p className="text-slate-300 text-xs sm:text-sm mt-2.5 leading-relaxed">
                          {video.summary}
                        </p>
                      </div>
                    </div>

                    {/* Interactive Syllabus Preview Expansion */}
                    <div className="px-5 pb-5">
                      {isSelected ? (
                        <div className="pt-3 border-t border-slate-700 space-y-3">
                          <div className="flex flex-wrap gap-1.5">
                            {video.topics.map((topic, i) => (
                              <span
                                key={i}
                                className="text-[11px] font-semibold bg-amber-500/15 text-amber-300 border border-amber-400/30 px-2.5 py-1 rounded-full"
                              >
                                ✓ {topic}
                              </span>
                            ))}
                          </div>
                          <a
                            href="https://www.youtube.com/@Gyankendra26"
                            target="_blank"
                            rel="noopener noreferrer"
                            onClick={(e) => e.stopPropagation()}
                            className="w-full inline-flex items-center justify-center gap-1.5 bg-rose-600 hover:bg-rose-500 text-white font-bold py-2.5 px-4 rounded-xl text-xs transition-colors"
                          >
                            <Youtube className="w-4 h-4" />
                            <span>YouTube-ত সম্পূৰ্ণ ভিডিঅ’ চাওক</span>
                            <ExternalLink className="w-3.5 h-3.5" />
                          </a>
                        </div>
                      ) : (
                        <div className="text-xs font-bold text-amber-400 flex items-center gap-1">
                          <span>
                            {lang === 'as'
                              ? 'পাঠ্যসূচী চাবলৈ ক্লিক কৰক'
                              : 'Click to preview lesson topics'}
                          </span>
                          <ChevronRight className="w-3.5 h-3.5" />
                        </div>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      </section>

      {/* 7. SEBA CLASS 10 STUDY MATERIALS SECTION (অধ্যয়ন সামগ্ৰী - অসমীয়া মাধ্যম) */}
      <section
        id="study-materials"
        className="py-16 md:py-24 bg-white border-b border-slate-200"
      >
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-3xl">
            <span className="text-xs sm:text-sm font-extrabold uppercase tracking-wider text-amber-600">
              {t.materials.eyebrow}
            </span>
            <h2 className="text-2xl sm:text-3xl md:text-4xl font-extrabold text-slate-900 mt-2">
              {t.materials.title}
            </h2>
            <p className="text-slate-600 text-sm sm:text-base mt-3 leading-relaxed">
              {t.materials.subtitle}
            </p>
          </div>

          {/* Category Filter Tabs */}
          <div className="flex flex-wrap items-center gap-2.5 mt-8 pb-6 border-b border-slate-200">
            {[
              { id: 'all', label: t.materials.tabs.all },
              { id: 'free', label: t.materials.tabs.free },
              { id: 'paid', label: t.materials.tabs.paid }
            ].map((tab) => {
              const active = materialFilter === tab.id;
              return (
                <button
                  key={tab.id}
                  onClick={() => setMaterialFilter(tab.id)}
                  className={`px-4 py-2.5 rounded-xl text-xs sm:text-sm font-bold transition-all cursor-pointer ${
                    active
                      ? 'bg-slate-900 text-amber-300 shadow-sm'
                      : 'bg-slate-100 text-slate-700 hover:bg-slate-200'
                  }`}
                >
                  {tab.label}
                </button>
              );
            })}
          </div>

          {/* Study Materials Grid */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mt-8">
            {filteredMaterials.map((item) => {
              const isPaid = item.category === 'paid';
              return (
                <div
                  key={item.id}
                  className={`rounded-3xl p-6 flex flex-col justify-between transition-all ${
                    isPaid
                      ? 'bg-gradient-to-b from-amber-50/90 to-white border-2 border-amber-400 shadow-md'
                      : 'bg-slate-50/70 border border-slate-200 hover:border-slate-300 shadow-2xs'
                  }`}
                >
                  <div>
                    {/* Top Badge Row */}
                    <div className="flex items-center justify-between gap-2 mb-4">
                      <span
                        className={`text-xs font-extrabold px-3 py-1 rounded-full ${
                          isPaid
                            ? 'bg-slate-900 text-amber-300'
                            : 'bg-emerald-100 text-emerald-800'
                        }`}
                      >
                        {item.badge}
                      </span>

                      {item.discount && (
                        <span className="text-xs font-extrabold bg-amber-500 text-slate-950 px-2.5 py-1 rounded-full">
                          {item.discount}
                        </span>
                      )}
                    </div>

                    {/* Title & Description */}
                    <h3 className="text-lg font-extrabold text-slate-900 leading-snug">
                      {item.title}
                    </h3>
                    <p className="text-sm text-slate-600 mt-2.5 leading-relaxed">
                      {item.description}
                    </p>

                    {/* Optional Highlights for Guidebook & Model Sets */}
                    {item.highlights && (
                      <ul className="mt-4 space-y-1.5">
                        {item.highlights.map((hl, i) => (
                          <li
                            key={i}
                            className="flex items-center gap-2 text-xs font-semibold text-slate-700"
                          >
                            <CheckCircle2 className="w-4 h-4 text-amber-600 shrink-0" />
                            <span>{hl}</span>
                          </li>
                        ))}
                      </ul>
                    )}
                  </div>

                  {/* Bottom Price / CTA Footer */}
                  <div className="mt-6 pt-4 border-t border-slate-200/80">
                    {isPaid ? (
                      <div className="space-y-3">
                        <div className="flex items-baseline gap-2.5">
                          <span className="text-2xl font-extrabold text-slate-900">
                            {item.price}
                          </span>
                          {item.mrp && (
                            <span className="text-sm font-semibold text-slate-400 line-through">
                              MRP {item.mrp}
                            </span>
                          )}
                        </div>
                        <button
                          onClick={() => setOrderModalItem(item)}
                          className="w-full inline-flex items-center justify-center gap-2 bg-slate-900 hover:bg-slate-800 text-amber-300 font-extrabold px-4 py-3 rounded-xl text-sm transition-colors cursor-pointer"
                        >
                          <ShoppingBag className="w-4 h-4" />
                          <span>
                            {item.actionType === 'order_guide'
                              ? t.materials.orderBtn
                              : t.materials.inquireSetBtn}
                          </span>
                        </button>
                      </div>
                    ) : (
                      <a
                        href={item.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="w-full inline-flex items-center justify-center gap-2 bg-emerald-600 hover:bg-emerald-500 text-white font-bold px-4 py-3 rounded-xl text-sm transition-colors"
                      >
                        <Download className="w-4 h-4" />
                        <span>{t.materials.downloadBtn}</span>
                      </a>
                    )}
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* 8. CONTACT & FOOTER */}
      <footer id="contact" className="bg-slate-950 text-slate-300 pt-16 pb-10">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-10 pb-12 border-b border-slate-800">
            {/* Brand & Educator Summary */}
            <div className="lg:col-span-5 space-y-4">
              <div className="flex items-center gap-3">
                <div className="w-11 h-11 rounded-xl bg-amber-500 text-slate-950 flex items-center justify-center font-extrabold text-lg">
                  DM
                </div>
                <div>
                  <div className="font-extrabold text-white text-lg">
                    DipankarMali.com
                  </div>
                  <div className="text-xs text-amber-400 font-semibold">
                    Gyan Kendra Tuition Center • Boromera
                  </div>
                </div>
              </div>
              <p className="text-sm text-slate-400 leading-relaxed">
                {t.contact.subtitle}
              </p>
              <div className="pt-1">
                <div className="text-xs font-bold uppercase tracking-wider text-amber-400 mb-1.5">
                  {t.contact.addressHeading}
                </div>
                <p className="text-sm text-slate-200 flex items-start gap-2">
                  <MapPin className="w-4 h-4 text-amber-400 shrink-0 mt-1" />
                  <span>
                    {t.contact.fullAddress}
                    <span className="block text-slate-400 text-xs mt-1">
                      {t.contact.assameseAddress}
                    </span>
                  </span>
                </p>
              </div>
            </div>

            {/* Direct Contact & WhatsApp */}
            <div className="lg:col-span-3 space-y-4">
              <h3 className="text-sm font-extrabold uppercase tracking-wider text-white">
                {t.contact.directCallHeading}
              </h3>
              <div className="space-y-3 text-sm">
                <a
                  href="tel:+917896723247"
                  className="flex items-center gap-2.5 text-slate-200 hover:text-amber-400 transition-colors"
                >
                  <Phone className="w-4 h-4 text-amber-400" />
                  <span className="font-semibold">+91 7896723247</span>
                </a>
                <a
                  href="https://wa.me/917896723247"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex items-center gap-2.5 text-emerald-400 hover:text-emerald-300 transition-colors font-semibold"
                >
                  <MessageCircle className="w-4 h-4" />
                  <span>WhatsApp: +91 7896723247</span>
                </a>
                <div className="flex items-center gap-2.5 text-slate-300">
                  <Globe className="w-4 h-4 text-sky-400" />
                  <span>dipankarmali.com</span>
                </div>
              </div>
            </div>

            {/* Official Digital Platforms */}
            <div className="lg:col-span-4 space-y-4">
              <h3 className="text-sm font-extrabold uppercase tracking-wider text-white">
                {t.contact.quickLinksHeading}
              </h3>
              <div className="grid grid-cols-1 gap-2.5 text-sm">
                <a
                  href="https://www.youtube.com/@Gyankendra26"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex items-center justify-between px-4 py-2.5 rounded-xl bg-slate-900 border border-slate-800 hover:border-rose-500/60 text-slate-200 transition-colors"
                >
                  <span className="flex items-center gap-2.5 font-semibold">
                    <Youtube className="w-4 h-4 text-rose-500" />
                    <span>YouTube: Gyan kendra26</span>
                  </span>
                  <ExternalLink className="w-3.5 h-3.5 text-slate-500" />
                </a>

                <a
                  href="https://t.me/gyankendra26"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex items-center justify-between px-4 py-2.5 rounded-xl bg-slate-900 border border-slate-800 hover:border-sky-500/60 text-slate-200 transition-colors"
                >
                  <span className="flex items-center gap-2.5 font-semibold">
                    <Send className="w-4 h-4 text-sky-400" />
                    <span>Telegram: @gyankendra26</span>
                  </span>
                  <ExternalLink className="w-3.5 h-3.5 text-slate-500" />
                </a>

                <a
                  href="https://whatsapp.com/channel/0029Vb7YYlADZ4LZOtGek320"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex items-center justify-between px-4 py-2.5 rounded-xl bg-slate-900 border border-slate-800 hover:border-emerald-500/60 text-slate-200 transition-colors"
                >
                  <span className="flex items-center gap-2.5 font-semibold">
                    <Bell className="w-4 h-4 text-emerald-400" />
                    <span>Official WhatsApp Channel</span>
                  </span>
                  <ExternalLink className="w-3.5 h-3.5 text-slate-500" />
                </a>
              </div>
            </div>
          </div>

          {/* Copyright Bar */}
          <div className="pt-8 flex flex-col sm:flex-row items-center justify-between gap-4 text-xs text-slate-400 text-center sm:text-left">
            <p>{t.contact.copyright}</p>
            <p className="text-slate-500">
              Boromera, Agomani • Dist. Dhubri, Assam (783335)
            </p>
          </div>
        </div>
      </footer>

      {/* ORDER / UPI PAYMENT MODAL FOR GUIDEBOOK & MODEL SETS */}
      {orderModalItem && (
        <div
          className="fixed inset-0 z-50 bg-slate-950/75 backdrop-blur-xs flex items-center justify-center p-4"
          onClick={() => setOrderModalItem(null)}
        >
          <div
            className="bg-white border border-slate-200 rounded-3xl max-w-lg w-full p-6 sm:p-7 shadow-2xl relative animate-in fade-in zoom-in-95 duration-150"
            onClick={(e) => e.stopPropagation()}
          >
            <button
              onClick={() => setOrderModalItem(null)}
              aria-label={t.modal.closeBtn}
              className="absolute top-5 right-5 p-2 rounded-full bg-slate-100 hover:bg-slate-200 text-slate-700 transition-colors cursor-pointer"
            >
              <X className="w-5 h-5" />
            </button>

            <div className="inline-flex items-center gap-1.5 bg-amber-100 text-amber-900 text-xs font-extrabold px-3 py-1 rounded-full mb-3">
              <ShoppingBag className="w-3.5 h-3.5" />
              <span>{orderModalItem.price}</span>
            </div>

            <h3 className="text-xl font-extrabold text-slate-900 pr-8 leading-snug">
              {orderModalItem.actionType === 'order_guide'
                ? t.modal.titleGuide
                : t.modal.titleSets}
            </h3>
            <p className="text-sm text-slate-600 mt-2 leading-relaxed">
              {t.modal.subtitle}
            </p>

            {/* UPI ID Box */}
            <div className="mt-5 bg-slate-900 text-white rounded-2xl p-4">
              <div className="text-xs text-amber-300 font-semibold">
                {t.modal.upiLabel}
              </div>
              <div className="flex items-center justify-between gap-3 mt-1.5">
                <code className="text-base sm:text-lg font-extrabold tracking-wide text-white">
                  7896723247@upi
                </code>
                <button
                  onClick={handleCopyUpi}
                  className="inline-flex items-center gap-1.5 bg-amber-500 hover:bg-amber-400 text-slate-950 font-extrabold px-3.5 py-2 rounded-xl text-xs transition-colors cursor-pointer shrink-0"
                >
                  {upiCopied ? (
                    <>
                      <Check className="w-4 h-4" />
                      <span>{t.modal.copiedBtn}</span>
                    </>
                  ) : (
                    <>
                      <Copy className="w-4 h-4" />
                      <span>{t.modal.copyBtn}</span>
                    </>
                  )}
                </button>
              </div>
            </div>

            {/* 3-Step Order Instructions */}
            <div className="mt-5 space-y-2.5">
              <div className="text-xs font-extrabold uppercase tracking-wider text-slate-500">
                {t.modal.stepsTitle}
              </div>
              {t.modal.steps.map((step, i) => (
                <div key={i} className="flex items-start gap-2.5 text-sm text-slate-700">
                  <span className="w-5 h-5 rounded-full bg-amber-100 text-amber-900 font-extrabold text-xs flex items-center justify-center shrink-0 mt-0.5">
                    {i + 1}
                  </span>
                  <span>{step}</span>
                </div>
              ))}
            </div>

            {/* One-Click WhatsApp Order Confirmation */}
            <div className="mt-6 flex flex-col sm:flex-row gap-3">
              <a
                href={`https://wa.me/917896723247?text=${encodeURIComponent(
                  lang === 'as'
                    ? `নমস্কাৰ মালী ছাৰ,\nমই "${orderModalItem.title}" অৰ্ডাৰ কৰিব বিচাৰোঁ।\nUPI ID (7896723247@upi)-ত পেমেণ্ট কৰি স্ক্ৰীণশ্বট পঠিয়াইছোঁ।`
                    : `Hello Mali Sir,\nI would like to order "${orderModalItem.title}".\nI am sharing my payment confirmation screenshot for UPI ID: 7896723247@upi.`
                )}`}
                target="_blank"
                rel="noopener noreferrer"
                className="flex-1 inline-flex items-center justify-center gap-2 bg-emerald-600 hover:bg-emerald-500 text-white font-extrabold px-5 py-3.5 rounded-xl text-sm shadow-md transition-colors"
              >
                <MessageCircle className="w-5 h-5" />
                <span>{t.modal.whatsappConfirmBtn}</span>
              </a>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
