import "./ParcelBackground.css";

export default function ParcelBackground() {
  return (
    <div className="parcel-bg-container" aria-hidden="true">
      <div className="parcel-scroll-layer">
        <svg
          className="parcel-bg-svg"
          viewBox="0 0 2400 2400"
          preserveAspectRatio="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <defs>
            <pattern
              id="parcel-tile"
              x="0"
              y="0"
              width="800"
              height="800"
              patternUnits="userSpaceOnUse"
            >
              {/* Urban grid block - top left area */}
              <rect x="20" y="20" width="95" height="65" fill="none" stroke="rgba(232, 211, 130, 0.35)" strokeWidth="1.2" />
              <rect x="120" y="20" width="80" height="65" fill="none" stroke="rgba(232, 211, 130, 0.35)" strokeWidth="1.2" />
              <rect x="205" y="20" width="110" height="65" fill="none" stroke="rgba(232, 211, 130, 0.35)" strokeWidth="1.2" />
              <rect x="20" y="90" width="95" height="55" fill="none" stroke="rgba(232, 211, 130, 0.35)" strokeWidth="1.2" />
              <rect x="120" y="90" width="80" height="55" fill="none" stroke="rgba(232, 211, 130, 0.35)" strokeWidth="1.2" />
              <rect x="205" y="90" width="110" height="55" fill="none" stroke="rgba(232, 211, 130, 0.35)" strokeWidth="1.2" />
              <rect x="20" y="150" width="95" height="70" fill="none" stroke="rgba(232, 211, 130, 0.35)" strokeWidth="1.2" />
              <rect x="120" y="150" width="80" height="70" fill="none" stroke="rgba(232, 211, 130, 0.35)" strokeWidth="1.2" />
              <rect x="205" y="150" width="60" height="70" className="parcel-flash flash-1" fill="rgba(232, 211, 130, 0.04)" stroke="rgba(232, 211, 130, 0.45)" strokeWidth="1.4" />
              <rect x="270" y="150" width="45" height="70" fill="none" stroke="rgba(232, 211, 130, 0.35)" strokeWidth="1.2" />

              {/* Irregular agricultural parcels - center */}
              <polygon points="340,30 440,25 460,95 425,130 340,120" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="445,25 560,35 570,90 465,95" className="parcel-flash flash-2" fill="rgba(232, 211, 130, 0.03)" stroke="rgba(232, 211, 130, 0.32)" strokeWidth="1.1" />
              <polygon points="465,95 570,90 580,165 440,155 425,130" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="340,125 425,130 440,155 430,230 335,225" fill="none" stroke="rgba(232, 211, 130, 0.28)" strokeWidth="1.1" />
              <polygon points="440,155 580,165 590,240 430,230" fill="rgba(232, 211, 130, 0.04)" stroke="rgba(232, 211, 130, 0.4)" strokeWidth="1.3" />

              {/* Large irregular blocks - top right */}
              <polygon points="600,20 720,30 730,110 680,130 595,105" fill="none" stroke="rgba(232, 211, 130, 0.33)" strokeWidth="1.2" />
              <polygon points="725,30 790,35 795,120 735,110" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="595,110 680,135 700,210 610,200" fill="none" stroke="rgba(232, 211, 130, 0.28)" strokeWidth="1.1" />
              <polygon points="680,135 735,115 750,200 700,210" className="parcel-flash flash-3" fill="rgba(232, 211, 130, 0.03)" stroke="rgba(232, 211, 130, 0.35)" strokeWidth="1.2" />
              <polygon points="735,115 795,125 795,205 750,200" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />

              {/* Road gap (horizontal) */}
              <line x1="0" y1="245" x2="330" y2="248" stroke="rgba(15, 30, 60, 0.6)" strokeWidth="12" />
              <line x1="0" y1="245" x2="330" y2="248" stroke="rgba(232, 211, 130, 0.12)" strokeWidth="0.8" strokeDasharray="6,8" />

              {/* Road gap (diagonal) */}
              <line x1="330" y1="248" x2="590" y2="245" stroke="rgba(15, 30, 60, 0.6)" strokeWidth="12" />
              <line x1="590" y1="245" x2="800" y2="260" stroke="rgba(15, 30, 60, 0.6)" strokeWidth="12" />
              <line x1="330" y1="248" x2="800" y2="260" stroke="rgba(232, 211, 130, 0.12)" strokeWidth="0.8" strokeDasharray="6,8" />

              {/* Mid-left subdivision parcels */}
              <polygon points="25,270 110,268 115,340 95,370 25,365" fill="none" stroke="rgba(232, 211, 130, 0.32)" strokeWidth="1.2" />
              <polygon points="115,268 200,270 205,365 115,340" className="parcel-flash flash-4" fill="rgba(232, 211, 130, 0.04)" stroke="rgba(232, 211, 130, 0.38)" strokeWidth="1.2" />
              <polygon points="205,270 320,272 318,365 205,365" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="25,370 95,375 90,450 25,445" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="100,375 205,370 210,450 95,450" fill="none" stroke="rgba(232, 211, 130, 0.33)" strokeWidth="1.2" />
              <polygon points="210,370 320,368 325,448 210,450" className="parcel-flash flash-6" fill="rgba(232, 211, 130, 0.03)" stroke="rgba(232, 211, 130, 0.35)" strokeWidth="1.2" />

              {/* Radial / fan-shaped parcels (like around a curve) */}
              <polygon points="360,270 430,265 450,330 380,340" fill="none" stroke="rgba(232, 211, 130, 0.32)" strokeWidth="1.1" />
              <polygon points="435,265 510,268 520,340 455,335" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="515,268 590,275 585,345 525,340" className="parcel-flash flash-5" fill="rgba(232, 211, 130, 0.04)" stroke="rgba(232, 211, 130, 0.38)" strokeWidth="1.2" />
              <polygon points="595,275 680,280 670,355 590,345" fill="none" stroke="rgba(232, 211, 130, 0.28)" strokeWidth="1.1" />
              <polygon points="685,280 770,285 765,360 675,355" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="380,345 455,340 470,420 395,425" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="460,340 530,342 540,425 475,420" className="parcel-flash flash-11" fill="rgba(232, 211, 130, 0.03)" stroke="rgba(232, 211, 130, 0.35)" strokeWidth="1.2" />
              <polygon points="535,342 595,348 590,430 545,425" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="600,348 675,358 665,435 595,430" fill="none" stroke="rgba(232, 211, 130, 0.32)" strokeWidth="1.1" />
              <polygon points="680,358 770,365 760,440 670,435" fill="none" stroke="rgba(232, 211, 130, 0.28)" strokeWidth="1.1" />

              {/* Vertical road gap */}
              <line x1="330" y1="248" x2="340" y2="530" stroke="rgba(15, 30, 60, 0.6)" strokeWidth="12" />
              <line x1="330" y1="248" x2="340" y2="530" stroke="rgba(232, 211, 130, 0.1)" strokeWidth="0.8" strokeDasharray="5,10" />

              {/* Bottom-left irregular parcels */}
              <polygon points="25,460 90,455 95,540 30,545" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="95,455 205,458 208,540 100,540" className="parcel-flash flash-7" fill="rgba(232, 211, 130, 0.04)" stroke="rgba(232, 211, 130, 0.4)" strokeWidth="1.3" />
              <polygon points="210,458 320,460 322,538 212,540" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="25,550 95,548 100,640 30,645" fill="none" stroke="rgba(232, 211, 130, 0.28)" strokeWidth="1.1" />
              <polygon points="100,548 210,545 215,640 105,640" fill="none" stroke="rgba(232, 211, 130, 0.32)" strokeWidth="1.1" />
              <polygon points="215,545 325,542 328,638 220,640" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />

              {/* Horizontal road through middle-bottom */}
              <line x1="0" y1="655" x2="800" y2="650" stroke="rgba(15, 30, 60, 0.5)" strokeWidth="14" />
              <line x1="0" y1="655" x2="800" y2="650" stroke="rgba(232, 211, 130, 0.1)" strokeWidth="0.8" strokeDasharray="8,12" />

              {/* Bottom row of parcels */}
              <polygon points="20,675 130,672 135,745 25,748" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="135,672 240,670 245,748 140,748" fill="rgba(232, 211, 130, 0.03)" stroke="rgba(232, 211, 130, 0.35)" strokeWidth="1.2" />
              <polygon points="245,670 330,672 335,750 250,748" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="360,668 470,665 475,745 365,748" fill="none" stroke="rgba(232, 211, 130, 0.32)" strokeWidth="1.1" />
              <polygon points="475,665 580,668 575,750 480,748" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="585,668 700,672 695,755 580,750" className="parcel-flash flash-8" fill="rgba(232, 211, 130, 0.04)" stroke="rgba(232, 211, 130, 0.38)" strokeWidth="1.2" />
              <polygon points="705,672 795,675 795,758 700,755" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />

              {/* Center-bottom irregular shapes */}
              <polygon points="360,435 470,430 480,520 365,525" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="475,430 580,435 575,525 485,520" fill="none" stroke="rgba(232, 211, 130, 0.32)" strokeWidth="1.1" />
              <polygon points="585,435 680,440 672,528 580,525" className="parcel-flash flash-9" fill="rgba(232, 211, 130, 0.03)" stroke="rgba(232, 211, 130, 0.36)" strokeWidth="1.2" />
              <polygon points="685,440 775,445 768,530 678,528" fill="none" stroke="rgba(232, 211, 130, 0.28)" strokeWidth="1.1" />

              {/* Curved road / arc boundary */}
              <path d="M 350,530 Q 450,560 560,535 Q 670,510 780,540" fill="none" stroke="rgba(15, 30, 60, 0.5)" strokeWidth="13" />
              <path d="M 350,530 Q 450,560 560,535 Q 670,510 780,540" fill="none" stroke="rgba(232, 211, 130, 0.12)" strokeWidth="0.8" strokeDasharray="5,8" />

              {/* Parcels below curve */}
              <polygon points="360,555 440,570 435,640 355,635" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="445,570 535,558 540,635 440,640" className="parcel-flash flash-10" fill="rgba(232, 211, 130, 0.04)" stroke="rgba(232, 211, 130, 0.38)" strokeWidth="1.2" />
              <polygon points="540,555 640,545 645,630 545,635" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="645,545 740,550 735,632 650,630" fill="none" stroke="rgba(232, 211, 130, 0.28)" strokeWidth="1.1" />
              <polygon points="745,550 795,555 795,635 740,632" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />

              {/* Edge parcels for seamless tiling - right edge */}
              <polygon points="775,35 800,35 800,115 775,112" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="775,120 800,120 800,200 775,198" fill="none" stroke="rgba(232, 211, 130, 0.28)" strokeWidth="1.1" />

              {/* Bottom-right corner parcels */}
              <polygon points="20,760 130,758 130,800 20,800" fill="none" stroke="rgba(232, 211, 130, 0.28)" strokeWidth="1.1" />
              <polygon points="135,758 250,755 250,800 135,800" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="360,755 480,752 480,800 360,800" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />
              <polygon points="485,752 590,755 590,800 485,800" className="parcel-flash flash-12" fill="rgba(232, 211, 130, 0.03)" stroke="rgba(232, 211, 130, 0.34)" strokeWidth="1.1" />
              <polygon points="595,755 700,758 700,800 595,800" fill="none" stroke="rgba(232, 211, 130, 0.28)" strokeWidth="1.1" />
              <polygon points="705,758 800,760 800,800 705,800" fill="none" stroke="rgba(232, 211, 130, 0.3)" strokeWidth="1.1" />

              {/* Boundary corner dots at parcel vertices */}
              {[
                [20,20],[115,20],[200,20],[315,20],[340,30],[440,25],[560,35],[600,20],[720,30],[790,35],
                [20,90],[115,90],[200,90],[315,90],
                [20,150],[115,150],[200,150],[265,150],[315,150],
                [25,270],[110,268],[200,270],[320,272],[430,265],[510,268],[590,275],[680,280],[770,285],
                [25,370],[95,375],[205,370],[320,368],
                [25,460],[90,455],[205,458],[320,460],
                [25,550],[95,548],[210,545],[325,542],
                [20,675],[130,672],[240,670],[330,672],[360,668],[470,665],[580,668],[700,672],[795,675],
              ].map(([cx, cy], idx) => (
                <circle
                  key={idx}
                  cx={cx}
                  cy={cy}
                  r="1.8"
                  fill="rgba(232, 211, 130, 0.5)"
                />
              ))}
            </pattern>
          </defs>

          {/* Fill entire viewBox with the tiling pattern */}
          <rect x="0" y="0" width="2400" height="2400" fill="url(#parcel-tile)" />

        </svg>
      </div>

      {/* Vignette overlay */}
      <div className="parcel-vignette" />
    </div>
  );
}
