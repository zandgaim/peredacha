// assets/js/hooks.js

// Hide arrow on scroll
const HideOnScroll = {
    mounted() {
      const arrow = this.el
  
      window.addEventListener("scroll", () => {
        if (window.scrollY > 50) {
          arrow.classList.add("opacity-0", "pointer-events-none")
        } else {
          arrow.classList.remove("opacity-0", "pointer-events-none")
        }
      })
    }
  }
  
  // Carousel enhancement hooks
  const Carousel = {
    mounted() {
      this.currentSlide = 0
      this.autoPlay = true
      this.autoPlayInterval = null
  
      this.startAutoPlay()
  
      // Keyboard navigation
      this.handleKeydown = this.handleKeydown.bind(this)
      document.addEventListener("keydown", this.handleKeydown)
  
      // Touch/swipe support
      this.touchStartX = 0
      this.touchEndX = 0
      this.handleTouchStart = this.handleTouchStart.bind(this)
      this.handleTouchEnd = this.handleTouchEnd.bind(this)
  
      this.el.addEventListener("touchstart", this.handleTouchStart, { passive: true })
      this.el.addEventListener("touchend", this.handleTouchEnd, { passive: true })
  
      // Pause autoplay on hover
      this.el.addEventListener("mouseenter", () => this.pauseAutoPlay())
      this.el.addEventListener("mouseleave", () => this.resumeAutoPlay())
    },
  
    destroyed() {
      this.stopAutoPlay()
      document.removeEventListener("keydown", this.handleKeydown)
      this.el.removeEventListener("touchstart", this.handleTouchStart)
      this.el.removeEventListener("touchend", this.handleTouchEnd)
    },
  
    startAutoPlay() {
      if (this.autoPlay && !this.autoPlayInterval) {
        this.autoPlayInterval = setInterval(() => {
          this.pushEvent("next_slide")
        }, 5000)
      }
    },
  
    stopAutoPlay() {
      if (this.autoPlayInterval) {
        clearInterval(this.autoPlayInterval)
        this.autoPlayInterval = null
      }
    },
  
    pauseAutoPlay() {
      this.stopAutoPlay()
    },
  
    resumeAutoPlay() {
      this.startAutoPlay()
    },
  
    handleKeydown(event) {
      switch (event.key) {
        case "ArrowLeft":
          event.preventDefault()
          this.pushEvent("prev_slide")
          break
        case "ArrowRight":
          event.preventDefault()
          this.pushEvent("next_slide")
          break
        case " ":
          event.preventDefault()
          this.pushEvent("toggle_autoplay")
          break
      }
    },
  
    handleTouchStart(event) {
      this.touchStartX = event.changedTouches[0].screenX
    },
  
    handleTouchEnd(event) {
      this.touchEndX = event.changedTouches[0].screenX
      this.handleSwipe()
    },
  
    handleSwipe() {
      const swipeThreshold = 50
      const diff = this.touchStartX - this.touchEndX
  
      if (Math.abs(diff) > swipeThreshold) {
        if (diff > 0) {
          this.pushEvent("next_slide")
        } else {
          this.pushEvent("prev_slide")
        }
      }
    }
  }

  const ScrollTop = {
    mounted() {
      this.handleScroll = () => window.scrollTo({ top: 0, behavior: "smooth" })
  
      this.handleLV = () => this.handleScroll()
      this.handleScroll()
  
      this.handleEvent("scroll_top", this.handleLV)
    },
    destroyed() {
      this.removeEventListener?.("scroll_top", this.handleLV)
    }
  }

  export default {
    Carousel,
    HideOnScroll,
    ScrollTop
  }
  