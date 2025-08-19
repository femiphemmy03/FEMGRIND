import React, { useState, useEffect } from "react";
import { useNavigate, Link } from "react-router-dom";

const HomePage = () => {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    username: "",
    email: "",
    subject: "",
    examType: "",
    useTimer: false,
    duration: 30,
  });

  // Rotational ads data
  const [currentAdIndex, setCurrentAdIndex] = useState(0);
  const [imageLoadError, setImageLoadError] = useState({});

  const adsData = [
    {
      id: 1,
      image: "/images/femgrind-ad1.jpg",
      link: "https://femgrindng.onrender.com",
      alt: "FEMGRIND - Your Success Partner",
      fallbackTitle: "FEMGRIND",
      fallbackSubtitle: "Your Success Partner",
      fallbackDescription: "Ace Your Exams with AI-Powered Practice",
    },
    {
      id: 2,
      image: "/images/femgrind-ad2.jpg",
      link: "https://femgrindng.onrender.com",
      alt: "FEMGRIND - Exam Excellence",
      fallbackTitle: "FEMGRIND",
      fallbackSubtitle: "Exam Excellence",
      fallbackDescription: "Your Path to Academic Success",
    },
  ];

  const subjects = [
    "Mathematics",
    "English",
    "Biology",
    "Chemistry",
    "Physics",
    "Economics",
    "Government",
    "Christian Religious Studies",
    "Civic Education",
    "Commerce",
  ];
  const examTypes = ["WAEC", "JAMB", "POST-UTME"];

  // Rotate ads every 10 seconds
  useEffect(() => {
    const interval = setInterval(() => {
      setCurrentAdIndex((prevIndex) =>
        prevIndex === adsData.length - 1 ? 0 : prevIndex + 1
      );
    }, 10000);

    return () => clearInterval(interval);
  }, [adsData.length]);

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: type === "checkbox" ? checked : value,
    }));
  };

  const handleStartExam = () => {
    if (!formData.username || !formData.email || !formData.subject || !formData.examType) {
      alert("Please fill in all fields to continue.");
      return;
    }
    navigate("/exam", { state: { ...formData } });
  };

  const handleAdClick = (link) => {
    window.open(link, "_blank", "noopener,noreferrer");
  };

  const handleImageError = (adId) => {
    setImageLoadError((prev) => ({ ...prev, [adId]: true }));
  };

  const renderFallbackContent = (ad) => (
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        height: "100%",
        background: "linear-gradient(135deg, var(--primary) 0%, var(--primary-hover) 100%)",
        color: "white",
        textAlign: "center",
        padding: "clamp(1rem, 3vw, 2rem)",
      }}
    >
      <h2
        style={{
          fontSize: "clamp(1.25rem, 4vw, 2rem)",
          marginBottom: "0.5rem",
          fontWeight: "bold",
        }}
      >
        {ad.fallbackTitle}
      </h2>
      <p
        style={{
          fontSize: "clamp(0.875rem, 3vw, 1.2rem)",
          marginBottom: "0.5rem",
          opacity: "0.9",
        }}
      >
        {ad.fallbackSubtitle}
      </p>
      <p style={{ fontSize: "clamp(0.75rem, 2.5vw, 1rem)", opacity: "0.8" }}>
        {ad.fallbackDescription}
      </p>
    </div>
  );

  const currentAd = adsData[currentAdIndex];

  return (
    <div className="app-container">
      <style jsx>{`
        :root {
          --primary: #7c3aed;
          --primary-hover: #6d28d9;
        }

        .desktop-layout {
          display: none;
        }

        .mobile-layout {
          display: block;
        }

        @media (min-width: 768px) {
          .mobile-layout {
            display: none;
          }
          .desktop-layout {
            display: block;
          }
        }

        .form-label-global {
          display: block;
          margin-bottom: 0.5rem;
          font-weight: 500;
          color: var(--primary);
        }

        .form-input-global,
        .form-select-global {
          width: 100%;
          padding: clamp(0.5rem, 2vw, 0.75rem);
          border: 1px solid #d1d5db;
          border-radius: 0.375rem;
          font-size: clamp(0.875rem, 3vw, 1rem);
          background-color: #fff;
        }

        .form-select-global {
          appearance: none;
          background-repeat: no-repeat;
          background-position: right 0.5rem center;
          background-size: 1.5em;
        }

        .btn-primary {
          background-color: var(--primary);
          color: white;
          border: none;
          border-radius: 0.375rem;
          cursor: pointer;
          transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
          background-color: var(--primary-hover);
        }

        .footer-global {
          text-align: center;
          padding: 1rem;
          background-color: var(--primary); /* Changed to match Start Exam button */
          font-size: clamp(0.75rem, 2.5vw, 0.875rem);
          width: 100%;
          box-sizing: border-box;
          z-index: 10;
          color: white; /* Ensure text is readable on purple background */
        }

        .footer-global p {
          margin: 0.25rem 0;
        }

        .footer-global a {
          color: white; /* Contrast with background */
          text-decoration: underline;
        }

        .footer-global a:hover {
          color: #e0e0e0; /* Light gray hover for visibility */
        }

        .card-3d {
          background: white;
          border-radius: 0.5rem;
          box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1),
            0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        .logo-global.bounce {
          animation: bounce 1s ease infinite;
        }

        @keyframes bounce {
          0%,
          100% {
            transform: translateY(0);
          }
          50% {
            transform: translateY(-5px);
          }
        }

        /* iPad Mini and tablet adjustments */
        @media (min-width: 768px) and (max-width: 1023px) {
          .ad-container {
            aspect-ratio: 16 / 9; /* Adjust to match your image dimensions */
            width: 100%;
          }
        }
      `}</style>

      <main
        style={{
          minHeight: "calc(100vh - 140px)",
          padding: "1rem 0.5rem",
        }}
      >
        {/* Desktop and Tablet Layout */}
        <div className="desktop-layout">
          <div
            style={{
              display: "flex",
              alignItems: "stretch",
              gap: "2rem",
              maxWidth: "1400px",
              margin: "0 auto",
              minHeight: "calc(100vh - 200px)",
            }}
          >
            {/* Left Side - Rotational Ad Image (65% width) */}
            <div
              className="ad-container"
              style={{
                flex: "0 0 65%",
                aspectRatio: "16 / 9", // Adjust based on your image's aspect ratio
                position: "relative",
                borderRadius: "0.75rem",
                overflow: "hidden",
                cursor: "pointer",
                boxShadow:
                  "0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)",
                transition: "all 0.3s ease",
                transform: "translateY(0)",
              }}
              onClick={() => handleAdClick(currentAd.link)}
              onMouseEnter={(e) => {
                e.currentTarget.style.transform = "translateY(-5px)";
                e.currentTarget.style.boxShadow =
                  "0 25px 50px -12px rgba(0, 0, 0, 0.25)";
              }}
              onMouseLeave={(e) => {
                e.currentTarget.style.transform = "translateY(0)";
                e.currentTarget.style.boxShadow =
                  "0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)";
              }}
            >
              {!imageLoadError[currentAd.id] ? (
                <img
                  src={currentAd.image}
                  alt={currentAd.alt}
                  style={{
                    width: "100%",
                    height: "100%",
                    objectFit: "cover",
                    objectPosition: "center",
                    transition: "opacity 1s ease-in-out",
                    imageRendering: "crisp-edges",
                    imageRendering: "-webkit-optimize-contrast",
                  }}
                  onError={() => handleImageError(currentAd.id)}
                />
              ) : (
                renderFallbackContent(currentAd)
              )}

              {/* Ad Indicator Dots */}
              <div
                style={{
                  position: "absolute",
                  bottom: "1.5rem",
                  left: "50%",
                  transform: "translateX(-50%)",
                  display: "flex",
                  gap: "0.75rem",
                  background: "rgba(0, 0, 0, 0.3)",
                  padding: "0.5rem 1rem",
                  borderRadius: "2rem",
                  backdropFilter: "blur(4px)",
                }}
              >
                {adsData.map((_, index) => (
                  <div
                    key={index}
                    style={{
                      width: "10px",
                      height: "10px",
                      borderRadius: "50%",
                      background:
                        index === currentAdIndex
                          ? "white"
                          : "rgba(255, 255, 255, 0.5)",
                      transition: "all 0.3s ease",
                      cursor: "pointer",
                    }}
                    onClick={(e) => {
                      e.stopPropagation();
                      setCurrentAdIndex(index);
                    }}
                  />
                ))}
              </div>

              {/* Click to visit overlay */}
              <div
                style={{
                  position: "absolute",
                  top: "1rem",
                  right: "1rem",
                  background: "rgba(0, 0, 0, 0.7)",
                  color: "white",
                  padding: "0.5rem 1rem",
                  borderRadius: "0.5rem",
                  fontSize: "0.875rem",
                  backdropFilter: "blur(4px)",
                  opacity: "0.8",
                }}
              >
                Click to visit →
              </div>
            </div>

            {/* Right Side - Form (35% width) */}
            <div
              style={{
                flex: "0 0 35%",
                display: "flex",
                flexDirection: "column",
                justifyContent: "center",
              }}
            >
              <div
                className="card-3d"
                style={{
                  padding: "2rem",
                  display: "flex",
                  flexDirection: "column",
                  gap: "1.25rem",
                  maxWidth: "100%",
                }}
              >
                <h1
                  className="logo-global bounce text-center"
                  style={{
                    color: "var(--primary)",
                    fontSize: "2.5rem",
                    marginBottom: "0.5rem",
                  }}
                >
                  FEMGRIND
                </h1>
                <p
                  className="text-center"
                  style={{
                    fontSize: "0.875rem",
                    color: "var(--primary)",
                    opacity: "0.9",
                    marginBottom: "1.5rem",
                    fontStyle: "italic",
                  }}
                >
                  ....Grinding your exams successfully!
                </p>

                <div>
                  <label htmlFor="username" className="form-label-global">
                    Username
                  </label>
                  <input
                    id="username"
                    type="text"
                    name="username"
                    value={formData.username}
                    onChange={handleChange}
                    placeholder="Enter your name"
                    className="form-input-global"
                  />
                </div>

                <div>
                  <label htmlFor="email" className="form-label-global">
                    Email
                  </label>
                  <input
                    id="email"
                    type="email"
                    name="email"
                    value={formData.email}
                    onChange={handleChange}
                    placeholder="Enter your email"
                    className="form-input-global"
                  />
                </div>

                <div>
                  <label htmlFor="examType" className="form-label-global">
                    Exam Type
                  </label>
                  <select
                    id="examType"
                    name="examType"
                    value={formData.examType}
                    onChange={handleChange}
                    className="form-select-global"
                    style={{
                      backgroundImage: `url("data:image/svg+xml;utf8,<svg fill='%237C3AED' height='24' viewBox='0 0 24 24' width='24' xmlns='http://www.w3.org/2000/svg'><path d='M7 10l5 5 5-5z'/><path d='M0 0h24v24H0z' fill='none'/></svg>")`,
                      backgroundRepeat: "no-repeat",
                      backgroundPosition: "right 0.5rem center",
                    }}
                  >
                    <option value="">-- Choose an exam type --</option>
                    {examTypes.map((e, i) => (
                      <option key={i} value={e}>
                        {e}
                      </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label htmlFor="subject" className="form-label-global">
                    Subject
                  </label>
                  <select
                    id="subject"
                    name="subject"
                    value={formData.subject}
                    onChange={handleChange}
                    className="form-select-global"
                    style={{
                      backgroundImage: `url("data:image/svg+xml;utf8,<svg fill='%237C3AED' height='24' viewBox='0 0 24 24' width='24' xmlns='http://www.w3.org/2000/svg'><path d='M7 10l5 5 5-5z'/><path d='M0 0h24v24H0z' fill='none'/></svg>")`,
                      backgroundRepeat: "no-repeat",
                      backgroundPosition: "right 0.5rem center",
                    }}
                  >
                    <option value="">-- Choose a subject --</option>
                    {subjects.map((s, i) => (
                      <option key={i} value={s}>
                        {s}
                      </option>
                    ))}
                  </select>
                </div>

                <div
                  className="flex items-center gap-2"
                  style={{
                    fontSize: "0.875rem",
                    color: "var(--primary)",
                  }}
                >
                  <input
                    id="useTimer"
                    type="checkbox"
                    name="useTimer"
                    checked={formData.useTimer}
                    onChange={handleChange}
                  />
                  <label htmlFor="useTimer">Enable Timer</label>
                </div>

                {formData.useTimer && (
                  <div>
                    <label htmlFor="duration" className="form-label-global">
                      Duration (minutes)
                    </label>
                    <input
                      id="duration"
                      type="number"
                      name="duration"
                      value={formData.duration}
                      min="1"
                      onChange={handleChange}
                      className="form-input-global"
                    />
                  </div>
                )}

                <button
                  onClick={handleStartExam}
                  className="btn-primary"
                  style={{
                    padding: "1rem",
                    fontSize: "1.1rem",
                    marginTop: "1rem",
                    fontWeight: "600",
                  }}
                >
                  Start Exam
                </button>
              </div>
            </div>
          </div>
        </div>

        {/* Mobile Layout */}
        <div className="mobile-layout">
          <div
            style={{
              display: "flex",
              flexDirection: "column",
              alignItems: "center",
              gap: "clamp(0.75rem, 3vw, 1.25rem)",
              maxWidth: "100%",
              margin: "0 auto",
              padding: "0 clamp(0.5rem, 2vw, 1rem)",
              minHeight: "calc(100vh - 160px)",
              justifyContent: "flex-start",
            }}
          >
            {/* Mobile Ad Banner */}
            <div
              className="mobile-ad-banner"
              style={{
                width: "100%",
                maxWidth: "100vw",
                aspectRatio: "16 / 9", // Adjust based on your image's aspect ratio
                position: "relative",
                borderRadius: "0.5rem",
                overflow: "hidden",
                cursor: "pointer",
                boxShadow: "0 4px 8px rgba(0, 0, 0, 0.1)",
                transition: "all 0.3s ease",
              }}
              onClick={() => handleAdClick(currentAd.link)}
            >
              {!imageLoadError[currentAd.id] ? (
                <img
                  src={currentAd.image}
                  alt={currentAd.alt}
                  style={{
                    width: "100%",
                    height: "100%",
                    objectFit: "cover",
                    objectPosition: "center",
                    transition: "opacity 1s ease-in-out",
                    imageRendering: "crisp-edges",
                    imageRendering: "-webkit-optimize-contrast",
                  }}
                  onError={() => handleImageError(currentAd.id)}
                />
              ) : (
                <div
                  style={{
                    display: "flex",
                    flexDirection: "column",
                    alignItems: "center",
                    justifyContent: "center",
                    height: "100%",
                    background:
                      "linear-gradient(135deg, var(--primary) 0%, var(--primary-hover) 100%)",
                    color: "white",
                    textAlign: "center",
                    padding: "0.5rem",
                  }}
                >
                  <h2
                    style={{
                      fontSize: "clamp(1rem, 4vw, 1.25rem)",
                      marginBottom: "0.25rem",
                      fontWeight: "bold",
                    }}
                  >
                    {currentAd.fallbackTitle}
                  </h2>
                  <p
                    style={{
                      fontSize: "clamp(0.75rem, 3vw, 0.875rem)",
                      opacity: "0.9",
                    }}
                  >
                    {currentAd.fallbackSubtitle}
                  </p>
                </div>
              )}

              {/* Mobile Ad Indicator Dots */}
              <div
                style={{
                  position: "absolute",
                  bottom: "0.5rem",
                  left: "50%",
                  transform: "translateX(-50%)",
                  display: "flex",
                  gap: "0.375rem",
                  background: "rgba(0, 0, 0, 0.4)",
                  padding: "0.25rem 0.5rem",
                  borderRadius: "1rem",
                  backdropFilter: "blur(4px)",
                }}
              >
                {adsData.map((_, index) => (
                  <div
                    key={index}
                    style={{
                      width: "6px",
                      height: "6px",
                      borderRadius: "50%",
                      background:
                        index === currentAdIndex
                          ? "white"
                          : "rgba(255, 255, 255, 0.6)",
                      transition: "all 0.3s ease",
                      cursor: "pointer",
                    }}
                    onClick={(e) => {
                      e.stopPropagation();
                      setCurrentAdIndex(index);
                    }}
                  />
                ))}
              </div>

              {/* Mobile click indicator */}
              <div
                style={{
                  position: "absolute",
                  top: "0.375rem",
                  right: "0.375rem",
                  background: "rgba(0, 0, 0, 0.7)",
                  color: "white",
                  padding: "0.125rem 0.5rem",
                  borderRadius: "0.25rem",
                  fontSize: "clamp(0.625rem, 2.5vw, 0.75rem)",
                  backdropFilter: "blur(4px)",
                  opacity: "0.9",
                }}
              >
                Tap to visit
              </div>
            </div>

            {/* Mobile Form */}
            <div
              className="card-3d"
              style={{
                width: "100%",
                maxWidth: "100%",
                padding: "clamp(0.75rem, 3vw, 1.25rem)",
                display: "flex",
                flexDirection: "column",
                gap: "clamp(0.5rem, 2vw, 0.875rem)",
                margin: "0",
                boxSizing: "border-box",
                flex: "1",
              }}
            >
              <h1
                className="logo-global bounce text-center"
                style={{
                  color: "var(--primary)",
                  fontSize: "clamp(1.5rem, 6vw, 1.875rem)",
                  marginBottom: "0.25rem",
                }}
              >
                FEMGRIND
              </h1>
              <p
                className="text-center"
                style={{
                  fontSize: "clamp(0.75rem, 3vw, 0.875rem)",
                  color: "var(--primary)",
                  opacity: "0.9",
                  marginBottom: "0.75rem",
                  fontStyle: "italic",
                }}
              >
                ....Grinding your exams successfully!
              </p>

              <div>
                <label
                  htmlFor="username-mobile"
                  className="form-label-global"
                  style={{ fontSize: "clamp(0.75rem, 3vw, 0.875rem)" }}
                >
                  Username
                </label>
                <input
                  id="username-mobile"
                  type="text"
                  name="username"
                  value={formData.username}
                  onChange={handleChange}
                  placeholder="Enter your name"
                  className="form-input-global"
                  style={{ fontSize: "clamp(0.875rem, 3.5vw, 1rem)", padding: "0.625rem" }}
                />
              </div>

              <div>
                <label
                  htmlFor="email-mobile"
                  className="form-label-global"
                  style={{ fontSize: "clamp(0.75rem, 3vw, 0.875rem)" }}
                >
                  Email
                </label>
                <input
                  id="email-mobile"
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  placeholder="Enter your email"
                  className="form-input-global"
                  style={{ fontSize: "clamp(0.875rem, 3.5vw, 1rem)", padding: "0.625rem" }}
                />
              </div>

              <div>
                <label
                  htmlFor="examType-mobile"
                  className="form-label-global"
                  style={{ fontSize: "clamp(0.75rem, 3vw, 0.875rem)" }}
                >
                  Exam Type
                </label>
                <select
                  id="examType-mobile"
                  name="examType"
                  value={formData.examType}
                  onChange={handleChange}
                  className="form-select-global"
                  style={{
                    fontSize: "clamp(0.875rem, 3.5vw, 1rem)",
                    padding: "0.625rem",
                    backgroundImage: `url("data:image/svg+xml;utf8,<svg fill='%237C3AED' height='24' viewBox='0 0 24 24' width='24' xmlns='http://www.w3.org/2000/svg'><path d='M7 10l5 5 5-5z'/><path d='M0 0h24v24H0z' fill='none'/></svg>")`,
                    backgroundRepeat: "no-repeat",
                    backgroundPosition: "right 0.5rem center",
                  }}
                >
                  <option value="">-- Choose an exam type --</option>
                  {examTypes.map((e, i) => (
                    <option key={i} value={e}>
                      {e}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label
                  htmlFor="subject-mobile"
                  className="form-label-global"
                  style={{ fontSize: "clamp(0.75rem, 3vw, 0.875rem)" }}
                >
                  Subject
                </label>
                <select
                  id="subject-mobile"
                  name="subject"
                  value={formData.subject}
                  onChange={handleChange}
                  className="form-select-global"
                  style={{
                    fontSize: "clamp(0.875rem, 3.5vw, 1rem)",
                    padding: "0.625rem",
                    backgroundImage: `url("data:image/svg+xml;utf8,<svg fill='%237C3AED' height='24' viewBox='0 0 24 24' width='24' xmlns='http://www.w3.org/2000/svg'><path d='M7 10l5 5 5-5z'/><path d='M0 0h24v24H0z' fill='none'/></svg>")`,
                    backgroundRepeat: "no-repeat",
                    backgroundPosition: "right 0.5rem center",
                  }}
                >
                  <option value="">-- Choose a subject --</option>
                  {subjects.map((s, i) => (
                    <option key={i} value={s}>
                      {s}
                    </option>
                  ))}
                </select>
              </div>

              <div
                className="flex items-center gap-2"
                style={{
                  fontSize: "clamp(0.75rem, 3vw, 0.875rem)",
                  color: "var(--primary)",
                }}
              >
                <input
                  id="useTimer-mobile"
                  type="checkbox"
                  name="useTimer"
                  checked={formData.useTimer}
                  onChange={handleChange}
                />
                <label htmlFor="useTimer-mobile">Enable Timer</label>
              </div>

              {formData.useTimer && (
                <div>
                  <label
                    htmlFor="duration-mobile"
                    className="form-label-global"
                    style={{ fontSize: "clamp(0.75rem, 3vw, 0.875rem)" }}
                  >
                    Duration (minutes)
                  </label>
                  <input
                    id="duration-mobile"
                    type="number"
                    name="duration"
                    value={formData.duration}
                    min="1"
                    onChange={handleChange}
                    className="form-input-global"
                    style={{ fontSize: "clamp(0.875rem, 3.5vw, 1rem)", padding: "0.625rem" }}
                  />
                </div>
              )}

              <button
                onClick={handleStartExam}
                className="btn-primary"
                style={{
                  padding: "clamp(0.625rem, 2.5vw, 0.875rem)",
                  fontSize: "clamp(0.875rem, 3.5vw, 1rem)",
                  marginTop: "clamp(0.25rem, 1vw, 0.5rem)",
                  width: "100%",
                  boxSizing: "border-box",
                  minHeight: "44px",
                }}
              >
                Start Exam
              </button>
            </div>
          </div>
        </div>
      </main>

      {/* Restored Original Footer with Updated Background Color */}
      <footer className="footer-global">
           <p> <Link to="/terms" style={{ color: "inherit", textDecoration: "underline" }}> Terms of Use</Link>
             &nbsp; Support: <a href="mailto:Femgrindng@gmail.com">Femgrindng@gmail.com</a>   
                   </p>
            <p> &copy; FEMGRIND {new Date().getFullYear()}.     POWERED BY SUNMOLA TECHNOLOGIES.</p>
        </footer>
</div>
);
};

export default HomePage;